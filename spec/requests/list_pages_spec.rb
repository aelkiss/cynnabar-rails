require 'rails_helper'
require 'pry'

describe "GET /pages" do
  it "shows all the pages with title and slug" do
    page1 = create(:page)
    page2 = create(:page)

    get "/pages"
    expect(response.status).to eq(200)
    expect(response.body).to include(page1.title)
    expect(response.body).to include("<a href=\"/#{page1.slug}\">/#{page1.slug}</a>")
    expect(response.body).to include(page2.title)
    expect(response.body).to include("<a href=\"/#{page2.slug}\">/#{page2.slug}</a>")
  end
end
