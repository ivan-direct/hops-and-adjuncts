# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hops/new', type: :view do
  before(:each) do
    assign(:hop, Hop.new)
  end

  it 'renders new hop form' do
    render

    assert_select 'form[action=?][method=?]', hops_path, 'post' do
    end
  end
end
