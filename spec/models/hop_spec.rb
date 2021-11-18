# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hop, type: :model do
  let(:hop) { create(:hop, name: 'Citra') }
  let(:juicy_bits) { create(:beer, name: 'Juicy Bits', checkins: 53_700) }
  let(:citra_xx_juicy_bits) { create(:beer, name: 'Citra Extra Extra Juicy Bits', checkins: 2_100) }

  describe 'create' do
    it 'creates a new hop' do
      expect(create(:hop, name: 'Citra')).to be_truthy
    end
  end

  context 'validations' do
    describe 'name' do
      it 'must be present' do
        hop.name = nil
        expect(hop.valid?).to be_falsey
      end
    end
  end

  describe 'beers' do
    it 'adds beer associations to a hop' do
      hop.beers << [juicy_bits, citra_xx_juicy_bits]
      expect(hop.beers.size).to eq(2)
    end
  end

  describe 'total_checkins' do
    let(:expected_checkins) { juicy_bits.checkins + citra_xx_juicy_bits.checkins }

    it 'returns the sum of all beer checkins' do
      expect(hop.total_checkins).to eq(0)
      hop.beers << [juicy_bits, citra_xx_juicy_bits]
      expect(hop.total_checkins).to eq(expected_checkins)
    end
  end
end
