require 'rails_helper'
require 'pry'

include ERB::Util

RSpec.feature 'Page creation' do
  include_context 'when signed in through capybara'

  scenario 'saves the page' do
    sign_in(create(:user, :admin))
    newpage = build(:page)

    visit '/pages'
    click_on 'New Page'
    fill_in 'page_body', with: newpage.body
    fill_in 'page_slug', with: newpage.slug
    fill_in 'page_title', with: newpage.title

    click_on 'Preview'
    click_on 'Save'

    savedpage = Page.find_by_slug(newpage.slug)
    expect(savedpage.body).to eq(newpage.body)
    expect(savedpage.title).to eq(newpage.title)
  end
end
