require 'rails_helper'
require 'pry'

describe "PATCH /:slug" do
  include_context "when using devise/warden auth"
  context 'when logged in as an admin' do 
    before(:each) do
      sign_in(create(:user, :admin))
    end

    it "updates the body and redirects back to slug" do
      page = create(:page)
      newbody = "<h3>akljshdfkaljshdflkajsdhf</h3>"

      patch "/#{page.slug}", page: {body: newbody}, commit: 'Save'

      edited_page = Page.find_by_slug(page.slug)
      expect(response.status).to eq(302)
      expect(response.redirect_url).to include(page.slug)
      expect(edited_page.body).to eq(newbody)
      expect(edited_page.title).to eq(page.title)
    end

    it "redirects to changed slug when editing slug" do
      page = create(:page)
      newslug = "newslug"

      patch "/#{page.slug}", page: {slug: newslug}, commit: 'Save'

      expect(response.status).to eq(302)
      expect(response.redirect_url).to include(newslug)
    end

    it "gets a edit page with ckeditor" do
      page = create(:page)

      get "/#{page.slug}/edit"

      expect(response.status).to eq(200)
      expect(response.body).to include('ckeditor')
    end
  end
end
