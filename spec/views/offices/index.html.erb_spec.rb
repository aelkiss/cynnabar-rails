require 'rails_helper'

RSpec.describe "offices/index", type: :view do
  it "renders a list of offices" do
    offices = [create(:office), create(:office)]
    assign(:offices,offices)

    render

    offices.each do |office|
      assert_select "tr>td", :text => office.name, :count => 1
      assert_select "tr>td", :text => office.email, :count => 1
      assert_select "tr>td", :text => office.image, :count => 1
    end

  end
end
