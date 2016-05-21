require 'rails_helper'

RSpec.describe 'offices/index', type: :view do
  it 'renders a list of offices' do
    offices = [create(:office), create(:office)]
    assign(:offices, offices)

    render

    offices.each do |office|
      assert_select ".office_listed[id=office#{office.id}]", count: 1 do
        assert_select '.office_name', text: office.name, count: 1
        # obfuscated email link
        assert_select '.officer_name>script', count: 1
        assert_select "img[src='#{office.image}']", count: 1
      end
    end
  end
end
