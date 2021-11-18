# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hops/edit', type: :view do
  before(:each) do
    @hop = assign(:hop, Hop.create!)
  end

  it 'renders the edit hop form' do
    render

    assert_select 'form[action=?][method=?]', hop_path(@hop), 'post' do
    end
  end
end
