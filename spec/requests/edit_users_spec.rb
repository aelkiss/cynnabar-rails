require 'rails_helper'
require 'pry'

describe "GET /users" do
  context "as an unapproved user" do
    it "cannot approve itself" do
      user = create(:user,approved: false)
      sign_in(user)

      patch user_path(user), user: {approved: true}
      expect(response).to have_http_status(:forbidden)

      edited_user = User.find(user.id)
      expect(user.approved).to be_falsey
    end
  end

  context "as an approved user" do
    it "can update email" do
      user = create(:user,approved: true)
      sign_in(user)
      email = "alskdjflksjd@example.com"

      patch user_path(user), user: {email: email}

      edited_user = User.find(user.id)
      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include user_path(user)
      expect(edited_user.email).to eq(email)
    end

    it "cannot update role" do
      user = create(:user,approved: true)
      sign_in(user)

      patch user_path(user), user: {role: :admin}

      expect(response).to have_http_status(:forbidden)
      edited_user = User.find(user.id)
      expect(edited_user.role).to eq("normal")
    end
  end

end
