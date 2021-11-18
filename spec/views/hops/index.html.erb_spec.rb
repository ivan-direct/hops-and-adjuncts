# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hops/index', type: :view do
  before(:each) do
    assign(:hops, [
             Hop.create!,
             Hop.create!
           ])
  end

  it 'renders a list of hops' do
    render
  end
end
