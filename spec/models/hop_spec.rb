# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hop, type: :model do
  let(:hop) { create(:hop, name: 'Citra') }
  let(:juicy_bits) { create(:beer, name: 'Juicy Bits', checkins: 53_700) }
  let(:citra_xx_juicy_bits) { create(:beer, name: 'Citra Extra Extra Juicy Bits', checkins: 2_100) }

  describe '#create' do
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

      it 'must be unique' do
        hop2 = hop.dup
        expect(hop2.valid?).to be_falsey
      end
    end
  end

  context 'scopes' do
    describe 'new_varieties' do
      let(:chinook) { create(:hop, name: 'Chinook', created_at: Date.today - 7.months) }

      before do
        11.times do |i|
          create(:hop, name: "X-9N0#{i}", created_at: Date.today - i.days)
        end
      end
      it 'returns the 10 most recent' do
        hops = Hop.new_varieties
        expect(hops.size).to eq(10)
        expect(hops.include?(chinook)).to be_falsey
        expect(hops.first.name).to eq('X-9N00') # created today should be first
      end
    end
  end

  describe '#beers' do
    it 'adds beer associations to a hop' do
      hop.beers << [juicy_bits, citra_xx_juicy_bits]
      expect(hop.beers.size).to eq(2)
    end
  end

  describe '#total_checkins' do
    let(:expected_checkins) { juicy_bits.checkins + citra_xx_juicy_bits.checkins }

    it 'returns the sum of all beer checkins' do
      expect(hop.total_checkins).to eq(0)
      hop.beers << [juicy_bits, citra_xx_juicy_bits]
      expect(hop.total_checkins).to eq(expected_checkins)
    end
  end
end
