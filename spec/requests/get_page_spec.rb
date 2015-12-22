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
    newpage = create(:page, slug: 'home')

    get "/"
    expect(response.status).to eq(200)
    expect(response.body).to include(newpage.body)
  end
end
