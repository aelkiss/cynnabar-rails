require 'rails_helper'

RSpec.describe "offices/edit", type: :view do
  before(:each) do
    @office = assign(:office, Office.create!(
      :name => "MyString",
      :email => "MyString",
      :image => "MyString",
      :page => nil,
      :officer => nil
    ))
  end

  it "renders the edit office form" do
    render

    assert_select "form[action=?][method=?]", office_path(@office), "post" do

      assert_select "input#office_name[name=?]", "office[name]"

      assert_select "input#office_email[name=?]", "office[email]"

      assert_select "input#office_image[name=?]", "office[image]"

      assert_select "input#office_page_id[name=?]", "office[page_id]"

      assert_select "input#office_officer_id[name=?]", "office[officer_id]"
    end
  end
end
