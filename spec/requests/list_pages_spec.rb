require 'rails_helper'
require 'pry'

describe "GET /pages" do
  include_context "when using devise/warden auth"
  it "as an admin, shows all the pages with title and slug" do
    sign_in(create(:user, :admin))
    page1 = create(:page)
    page2 = create(:page)

    get "/pages"
    expect(response.status).to eq(200)
    expect(response.body).to include(page1.title)
    expect(response.body).to include("<a href=\"/#{page1.slug}\">/#{page1.slug}</a>")
    expect(response.body).to include(page2.title)
    expect(response.body).to include("<a href=\"/#{page2.slug}\">/#{page2.slug}</a>")
  end

  it "as a normal user, does not list pages" do
    sign_in(create(:user))
    get "/pages"
    expect(response.status).to eq(403)
  end

  it "when not logged in, does not list pages" do
    get "/pages"
    expect(response.status).to eq(403)
  end
end
