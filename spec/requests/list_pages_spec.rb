require 'rails_helper'
require 'pry'

describe "When getting a list of pages" do
  it "shows all the pages with title and slug" do
    page1 = create(:page)
    page2 = create(:page)

    get "/pages"
    expect(response.status).to eq(200)
    expect(response.body).to include("<a href=\"/#{page1.slug}\">#{page1.title}</a>")
    expect(response.body).to include("<a href=\"/#{page1.slug}\">#{page1.slug}</a>")
    expect(response.body).to include("<a href=\"/#{page2.slug}\">#{page2.title}</a>")
    expect(response.body).to include("<a href=\"/#{page2.slug}\">#{page2.slug}</a>")
  end
end
