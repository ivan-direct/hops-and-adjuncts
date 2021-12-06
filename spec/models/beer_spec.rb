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
        expect(beer.valid?).to be_truthy
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
    let(:citra) { create(:citra) }
    let(:mosaic) { create(:mosaic) }

    it 'adds hop associations to a beer' do
      beer.hops << [citra, mosaic]
      expect(beer.hops.size).to eq(2)
    end
  end

  describe 'self#calculate_rating' do
    let(:fresh_palette) { create(:fresh_palette) }
    let(:cosmic_torero) { create(:cosmic_torero) }
    let(:citra) { create(:citra) }
    let(:mosaic) { create(:mosaic) }

    it 'adds hop associations to a beer' do
      fresh_palette.hops << [mosaic]
      cosmic_torero.hops << [citra]
      return_hash = Beer.calculate_rating(citra)
      citra.reload
      expect(citra.rating).to eq(cosmic_torero.rating)
    end

    it 'handles hops without beers' do
      expect(Beer.calculate_rating(citra)).to be_nil
    end
  end
end
