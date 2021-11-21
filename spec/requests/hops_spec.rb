# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/hops', type: :request do
  # This is the sole html controller and is used as the root path for react #
  describe 'GET /index' do
    it 'renders a successful response' do
      get hops_url
      expect(response).to be_successful
    end
  end
end
