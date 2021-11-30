# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Hops', type: :request do
  describe 'GET /hops' do
    before do
      create(:hop, id: 2, name: 'Citra', rating: '4.25', ranking: '1')
      create(:hop, id: 1, name: 'Simcoe', rating: '4.0', ranking: '2')
    end

    it 'returns an array hop hashes ordered by rank' do
      get '/api/v1/hops', params: {}

      body = JSON.parse(response.body)
      citra_hop = body.first.fetch('hop')
      simcoe_hop = body.last.fetch('hop')

      expect(citra_hop.fetch('name')).to eq('Citra')
      expect(simcoe_hop.fetch('name')).to eq('Simcoe')
    end
  end

  describe 'GET /hops/:id' do
    before do
      create(:hop, id: 2, name: 'Citra', rating: '4.25', ranking: '1')
    end

    it 'returns hop' do
      get '/api/v1/hops/2', params: {}

      citra_hop = JSON.parse(response.body).fetch('hop')
      expect(citra_hop.fetch('name')).to eq('Citra')
    end
  end

  describe 'GET /hops/featured' do
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

  describe 'GET /hops/popular' do
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
end
