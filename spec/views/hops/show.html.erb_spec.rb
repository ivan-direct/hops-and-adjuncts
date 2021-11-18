# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hops/show', type: :view do
  before(:each) do
    @hop = assign(:hop, Hop.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
