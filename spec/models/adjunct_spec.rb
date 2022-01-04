# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adjunct, type: :model do
  let(:adjunct) { create(:coffee) }
  let(:nightmare_fuel) { create(:nightmare_fuel) }
  let(:cinnamon_vanilla_rum_ba_sandman) { create(:cinnamon_vanilla_rum_ba_sandman) }
  let(:cosmic_torero) { create(:cosmic_torero, checkins: 0)}

  describe '#create' do
    it 'creates a new adjunct' do
      expect(create(:adjunct)).to be_truthy
    end
  end

  context 'validations' do
    describe 'name' do
      it 'must be present' do
        adjunct.name = nil
        expect(adjunct.valid?).to be_falsey
      end

      it 'must be unique' do
        adjunct2 = adjunct.dup
        expect(adjunct2.valid?).to be_falsey
      end
    end
  end

  describe '#beers' do
    it 'adds beer associations to a adjunct' do
      adjunct.beers << [nightmare_fuel, cinnamon_vanilla_rum_ba_sandman]
      expect(adjunct.beers.size).to eq(2)
    end
  end

  describe '#total_checkins' do
    let(:expected_checkins) { nightmare_fuel.checkins + cinnamon_vanilla_rum_ba_sandman.checkins }

    it 'returns the sum of all beer checkins' do
      expect(adjunct.total_checkins).to eq(0)
      adjunct.beers << [nightmare_fuel, cinnamon_vanilla_rum_ba_sandman]
      expect(adjunct.total_checkins).to eq(expected_checkins)
    end
  end

  describe '#formatted_rating' do
    it 'rounds rating to two significant digits' do
      adjunct.rating = 4.3333333333
      expect(adjunct.formatted_rating).to eq(4.33)
    end
  end

  describe '#common_pairings' do
    context '2 common pairings' do
      before do
        beers = [nightmare_fuel, cinnamon_vanilla_rum_ba_sandman]
        adjunct.beers << beers
        coconut = create(:coconut)
        coconut.beers << beers
        vanilla = create(:vanilla)
        vanilla.beers << beers
      end

      it 'returns names of adjuncts paired in other beers' do
        expect(adjunct.common_pairings).to eq(['coconut', 'vanilla'])
      end
    end

    context 'no pairings' do
      it 'returns a blank array' do
        expect(adjunct.common_pairings).to eq([])
      end
    end
  end

  describe '#popular_beers' do
    context 'more than 5 beers' do
      before do
        # create one over the limit of 5
        6.times do |i|
          b = create(:beer, checkins: i * 10)
          adjunct.beers << b
        end
        # this beer should be first if sorted properly
        b = Beer.first
        b.update(checkins: 50_000, name: 'First')
      end

      it 'returns 5 beers with the highest checkins' do
        expect(adjunct.popular_beers.size).to eq(5)
        expect(adjunct.popular_beers.first).to eq(Beer.find_by(name: 'First'))
      end
    end
  end

  describe '#delta' do
    it 'returns 0 if ranking nil' do
      adjunct.ranking = nil
      expect(adjunct.delta).to eq(0)
    end

    it 'returns ranking delta' do
      adjunct.ranking = 1
      adjunct.previous_ranking = 11
      expect(adjunct.delta).to eq(10)
    end
  end

  describe '#beers_by_rating' do
    before do
      @b1 = create(:beer, rating: 5.0)
      @b2 = create(:beer, rating: 4.9)
      @b3 = create(:beer, rating: 3.0)
      @b4 = create(:beer, rating: 0.22)
      adjunct.beers = [@b2, @b4, @b1, @b3] # this order shouldn't matter
    end

    it 'returns beers ordered by rating' do
      expect(adjunct.beers_by_rating).to eq([@b1, @b2, @b3, @b4])
    end
  end

  describe 'self#popular' do
    it 'handles null attributes' do
      expect(Adjunct.popular).to eq([])
    end

    it 'returns only two adjuncts' do
      h1 = create(:adjunct, ranking: 1, previous_ranking: 2)
      h2 = create(:adjunct, ranking: 2, previous_ranking: 1)

      expect(Adjunct.popular).to eq([h1, h2])
    end

    it 'returns the limit (3) of adjuncts' do
      h1 = create(:adjunct, ranking: 1, previous_ranking: 6) #  5
      h2 = create(:adjunct, ranking: 2, previous_ranking: 3) #  1
      h3 = create(:adjunct, ranking: 4, previous_ranking: 4) #  0
      h4 = create(:adjunct, ranking: 3, previous_ranking: 1) # -2

      expect(Adjunct.popular).to eq([h1, h2, h3])
    end
  end

  describe 'self#refresh_stats' do
    before do
      @banana = create(:banana, ranking: 2)
      @cinnamon = create(:cinnamon, ranking: 1)
      failed_adjunct = create(:adjunct, name: 'Durian', rating: nil)
      @hazelnut = create(:hazelnut, ranking: 44)
    end

    it 'populates adjunct#rating and adjunct#ranking' do
      nightmare_fuel.adjuncts = [@hazelnut, @cinnamon]
      cinnamon_vanilla_rum_ba_sandman.adjuncts = [@cinnamon, @banana]
      # should not change adjunct ranking, rating since there are no checkins
      cosmic_torero.adjuncts = [@hazelnut, @cinnamon, @banana]

      Adjunct.refresh_stats
      @banana.reload
      expect(@banana.rating).to eq(3.98)
      expect(@banana.previous_ranking).to eq(2)
      expect(@banana.ranking).to eq(3)

      @cinnamon.reload
      expect(@cinnamon.rating).to eq(4.035)
      expect(@cinnamon.previous_ranking).to eq(1)
      expect(@cinnamon.ranking).to eq(2)

      @hazelnut.reload
      expect(@hazelnut.rating).to eq(4.09)
      expect(@hazelnut.previous_ranking).to eq(44)
      expect(@hazelnut.ranking).to eq(1)
    end
  end

  describe 'self#find_match' do
    context 'description mentions three adjuncts' do
      before do
        adjunct # load coffee factory too
        @banana = create(:banana)
        @pistachio = create(:pistachio)
        create(:marshmallow) # not mentioned
      end

      it 'should return adjuncts' do
        description = 'After 12 months in the barrel we added Novo coffee, thai bananas, and roasted pistachio for a truely decadent treat. 14.5%ABV'
        expect(Adjunct.find_match(description)).to eq([adjunct, @banana, @pistachio])
      end
    end

    context 'blank description' do
      it 'should return an empty array' do
        description = '  '
        expect(Adjunct.find_match(description)).to eq([])
      end
    end
  end

  describe 'self#search' do
    context 'query for El Dorado' do
      before do
        @cherries = create(:cherries, rating: 5.0)
        @almond = create(:almond, rating: 4.0)
        create(:marshmallow, rating: 0) # not rated
      end

      it 'should return array with 1 adjunct' do
        expect(Adjunct.search('cherries')).to eq([@cherries])
      end

      it 'should return all adjuncts with a rating' do
        expect(Adjunct.search('')).to eq([@cherries, @almond])
      end
    end

    context 'no adjuncts' do
      it 'should return an empty array' do
        expect(Adjunct.search('Durian')).to eq([])
      end
    end
  end
end
