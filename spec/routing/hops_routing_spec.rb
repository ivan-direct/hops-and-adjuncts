# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HopsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/hops').to route_to('hops#index')
    end

    it 'routes to #index' do
      expect(get: '/').to route_to('hops#index')
    end
  end
end
