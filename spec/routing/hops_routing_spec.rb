# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HopsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/hops').to route_to('hops#index')
    end

    it 'routes to #new' do
      expect(get: '/hops/new').to route_to('hops#new')
    end

    it 'routes to #show' do
      expect(get: '/hops/1').to route_to('hops#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/hops/1/edit').to route_to('hops#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/hops').to route_to('hops#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/hops/1').to route_to('hops#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/hops/1').to route_to('hops#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/hops/1').to route_to('hops#destroy', id: '1')
    end
  end
end
