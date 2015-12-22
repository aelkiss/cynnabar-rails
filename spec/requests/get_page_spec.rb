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

  # TODO: move to view tests?
  context 'when logged in as a regular user' do
    include_context "when using devise/warden auth"

    it "shows an edit link for pages owned by that user" do
      user = create(:user)
      page = create(:page, user: user)

      sign_in(user)
      get "/#{page.slug}"

      expect(response.body).to include("/#{page.slug}/edit")
    end

    it "does not show an edit link for pages not owned by that user" do
      user = create(:user)
      page = create(:page)

      sign_in(user)
      get "/#{page.slug}"

      expect(response.body).not_to include("/#{page.slug}/edit")
    end
  end

  context 'when logged in as an admin' do
    include_context "when using devise/warden auth"

    it "always shows an edit link" do
      user = create(:user, :admin)
      page = create(:page)

      sign_in(user)
      get "/#{page.slug}"

      expect(response.body).to include("/#{page.slug}/edit")
    end
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
