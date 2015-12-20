require 'rails_helper'
require 'pry'

RSpec.feature "User visits a page by alias" do
  scenario "they get the right page" do
    newpage = create(:page)

    visit "/#{newpage.slug}"
    expect(page.html).to include(newpage.body)
  end
end
