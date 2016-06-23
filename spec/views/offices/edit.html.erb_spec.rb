# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'offices/edit', type: :view do
  before(:each) do
    @office = assign(:office, create(:office))
    @page = create(:page)
  end

  it 'renders the edit office form' do
    render

    assert_select 'form[action=?][method=?]', office_path(@office), 'post' do
      assert_select 'input#office_name[name=?]', 'office[name]'

      assert_select 'input#office_email[name=?]', 'office[email]'

      assert_select 'input#office_image[name=?]', 'office[image]'

      assert_select 'select#office_page_id[name=?]', 'office[page_id]'

      assert_select 'select#office_officer_id[name=?]', 'office[officer_id]'
    end
  end

  it 'has an option for selecting the user' do
    user = create(:user)
    render
    assert_select 'option', text: user.to_s
  end

  it 'has an option for selecting the page' do
    page = create(:page)
    render
    assert_select 'option', text: page.slug
  end
end
