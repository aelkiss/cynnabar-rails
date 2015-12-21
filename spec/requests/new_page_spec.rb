require 'rails_helper'
require 'pry'

describe "POST /pages" do
  include_context "when using devise/warden auth"
  context 'when logged in as an admin' do 
    it "allows creating pages" do
      sign_in(create(:user, :admin))
      page = attributes_for(:page)

      post "/pages", page: page, commit: 'Save'

      edited_page = Page.find_by_slug(page[:slug])
      expect(response.status).to eq(302)
      expect(response.redirect_url).to include(page[:slug])
      expect(edited_page.body).to eq(page[:body])
      expect(edited_page.title).to eq(page[:title])
    end
  end

  context 'when logged in as a regular user' do
    it "does not allow creating pages" do
      expect_page_action_to_fail_with_user(create(:user))
    end

    it "does not allow previewing pages" do
      expect_page_action_to_fail_with_user(create(:user),commit='Preview') 
    end
  end

  context 'when not logged in' do
    it "does not allow creating pages" do
      expect_page_action_to_fail_with_user(nil)
    end

    it "does not allow previewing pages" do
      expect_page_action_to_fail_with_user(nil,commit='Preview') 
    end
  end

  def expect_page_action_to_fail_with_user(user = nil, commit = 'Save')
    if(user)
      sign_in(user)
    end

    page = attributes_for(:page)
    post "/pages", page: page, commit: commit

    expect(response.status).to eq(403)
  end
end
