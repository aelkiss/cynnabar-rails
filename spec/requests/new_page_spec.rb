require 'rails_helper'
require 'pry'

describe "POST /pages" do
  context 'when logged in as an admin' do 
    it "allows creating pages" do
      sign_in(create(:user, :admin))
      page = attributes_for(:page)

      post "/pages", page: page, commit: 'Save'

      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include(page[:slug])

      saved_page = Page.find(page[:slug])
      expect(saved_page.body).to eq(page[:body])
      expect(saved_page.title).to eq(page[:title])
    end

    it "allows creating pages owned by normal users" do
      sign_in(create(:user, :admin))
      user = create(:user)
      page = attributes_for(:page)
      page[:user_id] = user.id

      post "/pages", page: page, commit: 'Save'

      saved_page = Page.find(page[:slug])
      expect(saved_page.user).to eq(user)
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

    expect(response).to have_http_status(:forbidden)
  end
end
