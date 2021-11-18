# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hop, type: :model do
  describe 'create' do
    it 'creates a new hop' do
      expect(create(:hop, name: 'Citra')).to be_truthy
    end
  end

  describe 'beers' do
    let(:hop) { create(:hop, name: 'Citra') }
    let(:juicy_bits) { Beer.create(name: 'Juicy Bits') }
    let(:citra_xx_juicy_bits) { Beer.create(name: 'Citra Extra Extra Juicy Bits') }

    it 'adds beer associations to a hop' do
      hop.beers << [juicy_bits, citra_xx_juicy_bits]
      expect(hop.beers.size).to eq(2)
    end
  end
end
