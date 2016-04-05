require 'rails_helper'
require 'pry'

describe "GET /pages" do
  it "as an admin, shows all the pages with title, slug, and owner" do
    sign_in(create(:user, :admin))
    user = create(:user)
    page1 = create(:page)
    page1.user = user
    page2 = create(:page)

    get pages_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(page1.title)
    expect(response.body).to include("<a href=\"/#{page1.slug}\">/#{page1.slug}</a>")
    expect(response.body).to include(page2.title)
    expect(response.body).to include("<a href=\"/#{page2.slug}\">/#{page2.slug}</a>")
    expect(response.body).to include(user.name)
  end

  it "as a normal user, does not list pages" do
    sign_in(create(:user))
    get pages_path
    expect(response).to have_http_status(:forbidden)
  end

  it "when not logged in, does not list pages" do
    get pages_path
    expect(response).to have_http_status(:forbidden)
  end
end
