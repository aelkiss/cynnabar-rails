require 'rails_helper'
require 'pry'

describe "GET /:slug" do
  it "gets the right page" do
    page = create(:page)

    get "/#{page.slug}"
    expect(response.status).to eq(200)
    expect(response.body).to include(page.body)
    expect(response.body).to include("<title>#{page.title}</title>")
  end
end

describe "GET /" do
  it "shows the page with slug 'home'" do
    page = create(:page, slug: 'home')

    get "/"
    expect(response.status).to eq(200)
    expect(response.body).to include(page.body)
  end
end
