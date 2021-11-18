# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'create' do
    it 'creates a new beer' do
      expect(Beer.create(name: 'Duff')).to be_truthy
    end
  end

  describe 'hops' do
    let(:beer) { Beer.create(name: 'Duff') }
    let(:citra) { Hop.create(name: 'Citra') }
    let(:mosaic) { Hop.create(name: 'Mosaic') }

    it 'adds hop associations to a beer' do
      beer.hops << [citra, mosaic]
      expect(beer.hops.size).to eq(2)
    end
  end
end
