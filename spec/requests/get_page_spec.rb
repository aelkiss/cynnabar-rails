require 'rails_helper'
require 'pry'

describe "When visiting a page by alias" do
  it "gets the right page" do
    newpage = create(:page)

    get "/#{newpage.slug}"
    expect(response.status).to eq(200)
    expect(response.body).to include(newpage.body)
    expect(response.body).to include("<title>#{newpage.title}</title>")
  end

  it "gets a 404 if the page does not exist" do
    get "/nonexistent"
    expect(response.status).to eq(404)
    expect(response.body).to include('Not Found')
  end
end
