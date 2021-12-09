# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hop, type: :model do
  let(:hop) { create(:citra) }
  let(:juicy_bits) { create(:juicy_bits, checkins: 53_700) }
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
      let(:chinook) { create(:hop, name: 'Chinook', created_at: Time.zone.today - 7.months) }

      before do
        11.times do |i|
          create(:hop, name: "X-9N0#{i}", created_at: Time.zone.today - i.days)
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

  describe '#formatted_rating' do
    it 'rounds rating to two significant digits' do
      hop.rating = 4.3333333333
      expect(hop.formatted_rating).to eq(4.33)
    end
  end

  describe '#common_pairings' do
    context '2 common pairings' do
      before do
        beers = [juicy_bits, citra_xx_juicy_bits]
        hop.beers << beers
        mosaic = create(:mosaic)
        mosaic.beers << beers
        eldorado = create(:eldorado)
        eldorado.beers << beers
      end

      it 'returns names of hops paired in other beers' do
        expect(hop.common_pairings).to eq(['El Dorado', 'Mosaic'])
      end
    end

    context 'no pairings' do
      it 'returns a blank array' do
        expect(hop.common_pairings).to eq([])
      end
    end
  end

  describe '#popular_beers' do
    context 'more than 5 beers' do
      before do
        # create one over the limit of 5
        6.times do |i|
          b = create(:beer, checkins: i * 10)
          hop.beers << b
        end
        # this beer should be first if sorted properly
        b = Beer.first
        b.update(checkins: 50_000, name: 'First')
      end

      it 'returns 5 beers with the highest checkins' do
        expect(hop.popular_beers.size).to eq(5)
        expect(hop.popular_beers.first).to eq(Beer.find_by(name: 'First'))
      end
    end
  end

  describe '#delta' do
    it 'returns 0 if ranking nil' do
      hop.ranking = nil
      expect(hop.delta).to eq(0)
    end

    it 'returns ranking delta' do
      hop.ranking = 1
      hop.previous_ranking = 11
      expect(hop.delta).to eq(10)
    end
  end

  describe 'self#popular' do
    it 'handles null attributes' do
      expect(Hop.popular).to eq([])
    end

    it 'returns only two hops' do
      h1 = create(:hop, ranking: 1, previous_ranking: 2)
      h2 = create(:hop, ranking: 2, previous_ranking: 1)

      expect(Hop.popular).to eq([h1, h2])
    end

    it 'returns the limit (3) of hops' do
      h1 = create(:hop, ranking: 1, previous_ranking: 6) #  5
      h2 = create(:hop, ranking: 2, previous_ranking: 3) #  1
      h3 = create(:hop, ranking: 4, previous_ranking: 4) #  0
      h4 = create(:hop, ranking: 3, previous_ranking: 1) # -2

      expect(Hop.popular).to eq([h1, h2, h3])
    end
  end

  describe 'self#refresh_stats' do
    before do
      @vic_secret = create(:vic_secret, ranking: 2)
      @nelson_sauvin = create(:nelson_sauvin, ranking: 1)
      failed_hop = create(:hop, name: 'Failed Hop', rating: nil)
      @mosaic = create(:mosaic, ranking: 44)

      @steezy = create(:steezy)
      @perpetual_embrace = create(:perpetual_embrace)
    end

    it 'populates hop#rating and hop#ranking' do
      @steezy.hops = [@mosaic, @nelson_sauvin]
      @perpetual_embrace.hops = [@nelson_sauvin, @vic_secret]

      Hop.refresh_stats
      @vic_secret.reload
      expect(@vic_secret.rating).to eq(4.38)
      expect(@vic_secret.previous_ranking).to eq(2)
      expect(@vic_secret.ranking).to eq(1)

      @nelson_sauvin.reload
      expect(@nelson_sauvin.rating).to eq(4.32)
      expect(@nelson_sauvin.previous_ranking).to eq(1)
      expect(@nelson_sauvin.ranking).to eq(2)

      @mosaic.reload
      expect(@mosaic.rating).to eq(4.26)
      expect(@mosaic.previous_ranking).to eq(44)
      expect(@mosaic.ranking).to eq(3)
    end
  end

  describe 'self#find_match' do
    context 'description mentions three hops' do
      before do
        @eldo = create(:eldorado)
        @mosaic = create(:mosaic)
        create(:simcoe) # not mentioned
      end

      it 'should return hops' do
        description = 'Agressively dry hopped with El Dorado, Citra, and Mosaic hops. 7.5%ABV'
        expect(Hop.find_match(description)).to eq([@eldo, @mosaic])
      end
    end

    context 'blank description' do
      it 'should return an empty array' do
        description = '  '
        expect(Hop.find_match(description)).to eq([])
      end
    end
  end

  describe 'self#search' do
    context 'query for El Dorado' do
      before do
        @eldo = create(:eldorado, rating: 5.0)
        @mosaic = create(:mosaic, rating: 4.0)
        create(:simcoe, rating: 0) # not mentioned
      end

      it 'should return array with 1 hop' do
        expect(Hop.search('El Dorado')).to eq([@eldo])
      end

      it 'should return all hops with a rating' do
        expect(Hop.search('')).to eq([@eldo, @mosaic])
      end
    end

    context 'no hops' do
      it 'should return an empty array' do
        expect(Hop.search('Citra')).to eq([])
      end
    end
  end
end
