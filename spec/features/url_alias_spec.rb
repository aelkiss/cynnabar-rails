require 'rails_helper'
require 'pry'

RSpec.feature "Page preview" do
  scenario "does not save the page" do
    newpage = create(:page)
    newbody = "Some replacement text"

    visit "/#{newpage.slug}/edit"
    fill_in "page_body", with: newbody

    click_on "Preview"

    savedpage = Page.find_by_slug(newpage.slug)
    expect(savedpage.body).not_to eq(newbody)
  end


  scenario "shows the new content as a preview" do
    newpage = create(:page)
    newbody = "Some replacement text"

    visit "/#{newpage.slug}/edit"
    fill_in "page_body", with: newbody

    click_on "Preview"

    expect(page.html).to include(newbody)
  end

end
