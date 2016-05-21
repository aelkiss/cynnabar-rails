# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'GET /users' do
  context 'as an admin' do
    before(:each) { sign_in(create(:user, :admin)) }

    it 'shows all the users with all fields & link to approve' do
      user1 = create(:user)
      user2 = create(:user, :has_recipient, approved: false)

      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user1.name)
      expect(response.body).to include(user2.name)
      expect(response.body).to include("<a href=\"/users/#{user1.id}/contact\">#{user1.email}</a>")
      expect(response.body).to include("<a href=\"/recipients/#{user2.recipient_id}\">#{user2.recipient}</a>")
      expect(response.body).to match("href=\"/users/#{user2.id}.*Approve")
    end

    it 'does not show approve link for approved users' do
      user = create(:user, :has_recipient, approved: true)
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).not_to match("href=\"/users/#{user.id}.*Approve")
    end
  end

  it 'as a normal user, does not list users' do
    sign_in(create(:user))
    get users_path
    expect(response).to have_http_status(:forbidden)
  end

  it 'when not logged in, does not list users' do
    get users_path
    expect(response).to have_http_status(:forbidden)
  end
end
