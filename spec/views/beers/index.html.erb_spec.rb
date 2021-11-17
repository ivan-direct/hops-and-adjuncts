require 'rails_helper'

RSpec.describe "beers/index", type: :view do
  before(:each) do
    assign(:beers, [
      Beer.create!(),
      Beer.create!()
    ])
  end

  it "renders a list of beers" do
    render
  end
end
