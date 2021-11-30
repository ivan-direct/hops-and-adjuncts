# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/hops', type: :request do
  # This is the sole html controller
  describe 'GET /' do
    it 'renders a successful response' do
      get root_url
      expect(response).to be_successful
    end
  end
end
