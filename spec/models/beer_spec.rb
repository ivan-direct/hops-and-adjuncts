# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'create' do
    it 'creates a new beer' do
      expect(create(:beer)).to be_truthy
    end
  end

  context 'validations' do
    let(:beer) { build(:beer) }
    describe 'checkins' do
      it 'must be an integer' do
        beer.checkins = 55.5
        expect(beer.valid?).to be_falsey
      end

      it 'must be a positive value' do
        beer.checkins = -22
        expect(beer.valid?).to be_falsey
      end

      it 'must be present' do
        beer.checkins = nil
        expect(beer.valid?).to be_falsey
      end
    end

    describe 'rating' do
      it 'must be between 0 and 5' do
        beer.rating = -0.25
        expect(beer.valid?).to be_falsey
        beer.rating = 0.1
        expect(beer.valid?).to be_falsey
        beer.rating = 5.25
        expect(beer.valid?).to be_falsey
        beer.rating = 0.25
        expect(beer.valid?).to be_truthy
      end

      it 'must be present' do
        beer.rating = nil
        expect(beer.valid?).to be_falsey
      end
    end

    describe 'name' do
      it 'must be present' do
        beer.name = nil
        expect(beer.valid?).to be_falsey
      end

      it 'must be unique' do
        beer.save!
        beer2 = beer.dup 
        expect(beer2.valid?).to be_falsey
      end
    end

    describe 'style' do
      it 'must be an ipa, stout, or other' do
        beer.style = 'rauchbier'
        expect(beer.valid?).to be_falsey
      end
    end
  end

  describe 'hops' do
    let(:beer) { create(:beer) }
    let(:citra) { create(:hop, name: 'Citra') }
    let(:mosaic) { create(:hop, name: 'Mosaic') }

    it 'adds hop associations to a beer' do
      beer.hops << [citra, mosaic]
      expect(beer.hops.size).to eq(2)
    end
  end
end
