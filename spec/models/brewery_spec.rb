# frozen_string_literal: true

require 'rails_helper'
require 'open-uri'

RSpec.describe Brewery, type: :model do
  describe 'create' do
    it 'creates a new brewery' do
      expect(create(:brewery)).to be_truthy
    end
  end

  context 'validations' do
    it 'must have a name, city, and state' do
      brewery = Brewery.new
      expect(brewery.invalid?).to be_truthy
      brewery.name = 'Unique Beer Name'
      expect(brewery.invalid?).to be_truthy
      brewery.city = 'Fort Collins'
      expect(brewery.invalid?).to be_truthy
      brewery.state = 'CO'
      expect(brewery.valid?).to be_truthy
    end

    it 'must have a unique name' do
      brewery = create(:brewery)
      dup_brewery = brewery.dup
      expect(dup_brewery.invalid?).to be_truthy
    end
  end

  context 'self#populate_external_codes' do
    before do
      brewery_one = instance_double(Brewery, name: 'WeldWerks', city: 'Greeley', state: 'CO',
                                             populate_external_code: true)
      brewery_two = instance_double(Brewery, name: 'Knotted Root', city: 'Nederland', state: 'CO',
                                             populate_external_code: true)
      breweries = instance_double(ActiveRecord::Batches)

      expect(Brewery).to receive(:where).with(external_code: nil).and_return(breweries)
      expect(breweries).to receive(:find_each).and_yield(brewery_one).and_yield(brewery_two)
      expect(brewery_one).to receive(:populate_external_code)
      expect(brewery_two).to receive(:populate_external_code)
    end

    it 'calls populate_external_code on one brewery record' do
      Brewery.populate_external_codes
    end
  end

  context 'self#build_beer_list' do
    before do
      brewery_one = instance_double(Brewery, name: 'WeldWerks', city: 'Greeley', state: 'CO',
                                             find_beers: true, external_code: 'WeldWerk')
      brewery_two = instance_double(Brewery, name: 'Knotted Root', city: 'Nederland', state: 'CO',
                                             find_beers: true, external_code: 'Knotty1')
      # Brewery.where.not() is a bit tricky to mock
      breweries = instance_double(ActiveRecord::Batches)
      where_mock = instance_double(ActiveRecord::QueryMethods::WhereChain)

      expect(Brewery).to receive(:where).with(no_args).and_return(where_mock)
      expect(where_mock).to receive(:not).with(external_code: nil).and_return(breweries)
      expect(breweries).to receive(:find_each).and_yield(brewery_one).and_yield(brewery_two)
      expect(brewery_one).to receive(:find_beers)
      expect(brewery_two).to receive(:find_beers)
    end

    it 'calls populate_external_code on one brewery record' do
      Brewery.build_beer_list
    end
  end

  describe '#populate_external_code' do
    context 'match' do
      let(:brewery) { create(:brewery, name: 'Test Brewing Co') }
      let(:url) { "https://untappd.com/search?q=#{brewery.name}&type=brewery" }
      let(:test_file) { File.new("#{Rails.root}/spec/test_html_files/populate_external_code.html") }

      before do
        uri_mock = instance_double(URI::HTTPS, path: '/search', open: test_file)
        allow(URI).to receive(:parse).with(url).and_return(uri_mock)
      end

      it 'updates external_code' do
        brewery.populate_external_code
        brewery.reload
        expect(brewery.external_code).to eq('TestBrewCo/555')
      end
    end

    context 'multiple results' do
      let(:brewery) { create(:brewery, name: 'Generic Brewing Co') }
      let(:url) { "https://untappd.com/search?q=#{brewery.name}&type=brewery" }
      let(:test_file) { File.new("#{Rails.root}/spec/test_html_files/multiple_external_code.html") }

      before do
        uri_mock = instance_double(URI::HTTPS, path: '/search', open: test_file)
        allow(URI).to receive(:parse).with(url).and_return(uri_mock)
      end

      it 'does nothing' do
        brewery.populate_external_code
        brewery.reload
        expect(brewery.external_code).to be_nil
      end
    end

    context 'no results' do
      let(:brewery) { create(:brewery, name: 'Longshot Brewing') }
      let(:url) { "https://untappd.com/search?q=#{brewery.name}&type=brewery" }
      let(:test_file) { File.new("#{Rails.root}/spec/test_html_files/no_external_code.html") }

      before do
        uri_mock = instance_double(URI::HTTPS, path: '/search', open: test_file)
        allow(URI).to receive(:parse).with(url).and_return(uri_mock)
      end

      it 'does nothing' do
        brewery.populate_external_code
        brewery.reload
        expect(brewery.external_code).to be_nil
      end
    end
  end

  describe '#find_beers' do
    let(:type_ids) { [128, 61, 115, 296, 315, 227, 112, 284, 305, 280, 334, 252, 311, 248, 308, 99, 9, 294] }
    let(:brewery) { create(:brewery, name: 'Test Brewing Co', external_code: 'TestBrewCo') }

    context 'success' do
      context 'one IPA with Citra mentioned' do
        let(:test_file) { File.new("#{Rails.root}/spec/test_html_files/find_beers.html") }

        before do
          create(:citra)
          uri_mock = instance_double(URI::HTTPS, path: '/beer', open: test_file)

          type_ids.each do |type_id|
            url = "https://untappd.com/#{brewery.external_code}/beer?type_id=#{type_id}&sort=created_at_desc"
            allow(URI).to receive(:parse).with(url).and_return(uri_mock)
          end
        end

        it 'creates beer' do
          brewery.find_beers
          beer = Beer.last

          expect(beer.name).to eq('Jazzy')
          expect(beer.style).to eq('ipa')
          expect(beer.rating).to eq(4.15)
          expect(beer.checkins).to eq(885)
          expect(beer.brewery_id).to eq(brewery.id)
          expect(beer.external_id).to eq(5555)
        end
      end

      context 'no hops are mentioned' do
        let(:test_file) { File.new("#{Rails.root}/spec/test_html_files/no_match_beers.html") }

        before do
          create(:citra)
          uri_mock = instance_double(URI::HTTPS, path: '/beer', open: test_file)

          type_ids.each do |type_id|
            url = "https://untappd.com/#{brewery.external_code}/beer?type_id=#{type_id}&sort=created_at_desc"
            allow(URI).to receive(:parse).with(url).and_return(uri_mock)
          end
        end

        it 'does not create a beer record' do
          brewery.find_beers
          expect(Beer.count).to eq(0)
        end
      end
    end

    context 'error' do
      let(:brewery) { create(:brewery, name: 'Test Brewing Co', external_code: 'TestBrewCo') }

      before do
        type_ids.each do |type_id|
          url = "https://untappd.com/#{brewery.external_code}/beer?type_id=#{type_id}&sort=created_at_desc"
          allow(URI).to receive(:parse).and_raise(StandardError.new('404 Not Found'))
        end
      end

      it 'does not create a beer record' do
        brewery.find_beers
        brewery.reload
        expect(brewery.code_invalid).to be_truthy
      end
    end
  end
end
