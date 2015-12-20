require 'rails_helper'
require 'pry'

RSpec.describe "User visits a page by alias" do
  scenario "they get the right page" do
    newpage = create(:page)

    get "/#{newpage.slug}"
    expect(response.status).to be(200)
    expect(response.body).to include(newpage.body)
    expect(response.body).to include("<title>#{newpage.title}</title>")
  end

  scenario "they get a 404 if the page does not exist" do
    get "/nonexistent"
    expect(response.status).to be(404)
    expect(response.body).to include('Not Found')
  end
end
