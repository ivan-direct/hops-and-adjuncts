require 'rails_helper'

RSpec.describe "beers/new", type: :view do
  before(:each) do
    assign(:beer, Beer.new())
  end

  it "renders new beer form" do
    render

    assert_select "form[action=?][method=?]", beers_path, "post" do
    end
  end
end
