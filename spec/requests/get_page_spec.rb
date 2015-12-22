require 'rails_helper'
require 'pry'

describe "GET /:slug" do
  it "gets the right page" do
    newpage = create(:page)

    get "/#{newpage.slug}"
    expect(response.status).to eq(200)
    expect(response.body).to include(newpage.body)
    expect(response.body).to include("<title>#{newpage.title}</title>")
  end
end

describe "GET /" do
  it "shows the page with slug 'home'" do
    home = Page.find_by_slug('home')
    expect(home).not_to be(nil)

    get "/"
    expect(response.status).to eq(200)
    expect(response.body).to include(home.body)
  end
end
