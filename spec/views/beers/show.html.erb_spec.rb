# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'beers/show', type: :view do
  before(:each) do
    @beer = assign(:beer, Beer.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
