# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Adjuncts', type: :request do
  describe 'GET /adjuncts' do
    context 'success' do
      context 'default' do
        before do
          create(:coffee, id: 2, rating: '4.25', ranking: '1')
          create(:coconut, id: 1, rating: '4.000001', ranking: '2')
        end

        it 'returns an array adjunct hashes ordered by rank' do
          get '/api/v1/adjuncts', params: {}

          body = JSON.parse(response.body)
          coffee = body.first.fetch('adjunct')
          coconut = body.last.fetch('adjunct')

          expect(coffee.fetch('name')).to eq('Coffee')
          expect(coffee.fetch('common_pairings')).to eq([])
          expect(coconut.fetch('name')).to eq('Coconut')
          expect(coconut.fetch('rating')).to eq(4.0)
        end
      end

      context 'query' do
        before do
          create(:peanut_butter, id: 2, rating: '4.25', ranking: '1')
          create(:marshmallow, id: 1, rating: '4.000001', ranking: '2')
          create(:adjunct, id: 5, name: 'peanut flour', rating: '3.4', ranking: '66')
        end

        it 'returns an array adjunct hashes ordered by rank' do
          get '/api/v1/adjuncts', params: { query: 'peanut butter' }

          body = JSON.parse(response.body)
          expect(body.size).to eq(1)
          pb = body.first.fetch('adjunct')

          expect(pb.fetch('name')).to eq('Peanut Butter')
        end
      end
    end

    context 'error' do
      before do
        expect(Adjunct).to receive(:where).and_raise(StandardError.new('Some Unknown Error Occurred'))
      end

      it 'returns error message' do
        get '/api/v1/adjuncts/', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq('Some Unknown Error Occurred')
        expect(code).to eq(500)
      end
    end
  end

  describe 'GET /adjuncts/:id' do
    context 'adjunct located' do
      before do
        adjunct = create(:coffee, id: 2, rating: '4.25', ranking: '1')
        adjunct.beers << create(:beer, name: "BA Nightmare Fuel", rating: 4.5)
        adjunct.beers << create(:nightmare_fuel, rating: 4.2)
      end

      it 'returns adjunct' do
        get '/api/v1/adjuncts/2', params: {}

        adjunct = JSON.parse(response.body).fetch('adjunct')
        beer = adjunct.fetch('beers').last # test sorting order
        expect(adjunct.fetch('name')).to eq('Coffee')
        expect(adjunct.fetch('delta')).to eq(0)
        expect(beer.fetch('name')).to eq('Nightmare Fuel')
        expect(beer.fetch('rating')).to eq(4.2)
      end
    end

    context 'adjunct not found' do
      it 'returns error message' do
        get '/api/v1/adjuncts/2', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq("Couldn't find Adjunct with 'id'=2")
        expect(code).to eq(500)
      end
    end
  end

  describe 'GET /adjuncts/featured' do
    context 'adjunct located' do
      before do
        create(:coffee, featured: true)
      end

      it 'returns adjunct' do
        get '/api/v1/adjuncts/featured', params: {}

        body = JSON.parse(response.body)

        adjunct = body.fetch('adjunct')
        expect(adjunct.fetch('name')).to eq('Coffee')
      end
    end

    context 'featured adjunct adjunct not found' do
      it 'returns adjunct' do
        get '/api/v1/adjuncts/featured', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq("Couldn't find Featured Adjunct")
        expect(code).to eq(404)
      end
    end
  end

  describe 'GET /adjuncts/popular' do
    context 'success' do
      before do
        create(:adjunct, name: 'Oreos', ranking: 1, previous_ranking: 6)
        create(:adjunct, ranking: 2, previous_ranking: 3)
        create(:adjunct, ranking: 4, previous_ranking: 4)
        create(:adjunct, ranking: 3, previous_ranking: 1)
      end

      it 'returns hot adjuncts' do
        get '/api/v1/adjuncts/popular', params: {}

        body = JSON.parse(response.body)
        expect(body.size).to eq(3)
        adjunct = body.first.fetch('adjunct')
        expect(adjunct.fetch('name')).to eq('Oreos')
      end
    end

    context 'error' do
      before do
        expect(Adjunct).to receive(:popular).and_raise(StandardError.new('Some Unknown Error Occurred'))
      end

      it 'returns error message' do
        get '/api/v1/adjuncts/popular', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq('Some Unknown Error Occurred')
        expect(code).to eq(500)
      end
    end
  end
end
