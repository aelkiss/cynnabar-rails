require 'rails_helper'
require 'pry'

# TODO: make request spec instead of feature spec
RSpec.feature "User visits a page by alias" do
  scenario "they get the right page" do
    newpage = create(:page)

    visit "/#{newpage.slug}"
    expect(page.html).to include(newpage.body)
    expect(page.html).to include("<title>#{newpage.title}</title>")
  end

  scenario "they get a 404 if the page does not exist" do
    visit "/nonexistent"
    expect(page.status_code).to be(404)
    expect(page).to have_text('Not Found')
  end
end
