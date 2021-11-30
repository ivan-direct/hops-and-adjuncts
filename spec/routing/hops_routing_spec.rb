# frozen_string_literal: true

require 'rails_helper'

# routing test for the sole rails route
RSpec.describe HopsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/').to route_to('hops#index')
    end
  end
end
