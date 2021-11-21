# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::HopsController, type: :routing do
  describe 'routing' do
    it 'routes to api/v1/hops#index' do
      expect(get: 'api/v1/hops').to route_to('api/v1/hops#index')
    end
  end
end
