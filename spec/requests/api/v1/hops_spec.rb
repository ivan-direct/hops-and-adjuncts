# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hops', type: :request do
  describe 'GET /hops' do
    context 'success' do
      context 'default' do
        before do
          create(:hop, id: 2, name: 'Citra', rating: '4.25', ranking: '1')
          create(:hop, id: 1, name: 'Simcoe', rating: '4.000001', ranking: '2')
        end
  
        it 'returns an array hop hashes ordered by rank' do
          get '/api/v1/hops', params: {}
  
          body = JSON.parse(response.body)
          citra_hop = body.first.fetch('hop')
          simcoe_hop = body.last.fetch('hop')
  
          expect(citra_hop.fetch('name')).to eq('Citra')
          expect(citra_hop.fetch('common_pairings')).to eq([])
          expect(simcoe_hop.fetch('name')).to eq('Simcoe')
          expect(simcoe_hop.fetch('rating')).to eq(4.0)
        end
      end
  
      context 'query' do
        before do
          create(:hop, id: 2, name: 'Citra', rating: '4.25', ranking: '1')
          create(:hop, id: 1, name: 'Simcoe', rating: '4.000001', ranking: '2')
          create(:hop, id: 5, name: 'Citra Incognito', rating: '3.4', ranking: '66')
        end
  
        it 'returns an array hop hashes ordered by rank' do
          get '/api/v1/hops', params: { query: 'Citra' }
  
          body = JSON.parse(response.body)
          expect(body.size).to eq(1)
          citra_hop = body.first.fetch('hop')
  
          expect(citra_hop.fetch('name')).to eq('Citra')
        end
      end
    end

    context 'error' do
      before do
        expect(Hop).to receive(:order).and_raise(StandardError.new('Some Unknown Error Occurred'))
      end

      it 'returns error message' do
        get '/api/v1/hops/', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq('Some Unknown Error Occurred')
        expect(code).to eq(500)
      end
    end
  end

  describe 'GET /hops/:id' do
    context 'hop located' do
      before do
        create(:hop, id: 2, name: 'Citra', rating: '4.25', ranking: '1')
      end

      it 'returns hop' do
        get '/api/v1/hops/2', params: {}

        citra_hop = JSON.parse(response.body).fetch('hop')
        expect(citra_hop.fetch('name')).to eq('Citra')
        expect(citra_hop.fetch('delta')).to eq(0)
      end
    end

    context 'hop not found' do
      it 'returns error message' do
        get '/api/v1/hops/2', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq("Couldn't find Hop with 'id'=2")
        expect(code).to eq(500)
      end
    end
  end

  describe 'GET /hops/featured' do
    context 'hop located' do
      before do
        create(:citra, featured: true)
      end

      it 'returns hop' do
        get '/api/v1/hops/featured', params: {}

        body = JSON.parse(response.body)

        citra_hop = body.fetch('hop')
        expect(citra_hop.fetch('name')).to eq('Citra')
      end
    end

    context 'featured hop hop not found' do
      it 'returns hop' do
        get '/api/v1/hops/featured', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq("Couldn't find Featured Hop")
        expect(code).to eq(404)
      end
    end
  end

  describe 'GET /hops/popular' do
    context 'success' do
      before do
        create(:hop, name: 'Riwaka', ranking: 1, previous_ranking: 6)
        create(:hop, ranking: 2, previous_ranking: 3)
        create(:hop, ranking: 4, previous_ranking: 4)
        create(:hop, ranking: 3, previous_ranking: 1)
      end

      it 'returns hot hops' do
        get '/api/v1/hops/popular', params: {}

        body = JSON.parse(response.body)
        expect(body.size).to eq(3)
        riwaka_hop = body.first.fetch('hop')
        expect(riwaka_hop.fetch('name')).to eq('Riwaka')
      end
    end

    context 'error' do
      before do
        expect(Hop).to receive(:popular).and_raise(StandardError.new('Some Unknown Error Occurred'))
      end

      it 'returns error message' do
        get '/api/v1/hops/popular', params: {}

        message = JSON.parse(response.body).fetch('error_message')
        code = JSON.parse(response.body).fetch('code')
        expect(message).to eq('Some Unknown Error Occurred')
        expect(code).to eq(500)
      end
    end
  end
end
