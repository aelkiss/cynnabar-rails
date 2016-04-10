require 'rails_helper'
require 'pry'

describe "GET /users" do
  it "as an admin, shows all the users with all fields & link to approve" do
    sign_in(create(:user, :admin))
    user1 = create(:user)
    user2 = create(:user, :has_recipient, approved: false)

    get users_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(user1.name)
    expect(response.body).to include(user2.name)
    expect(response.body).to include("<a href=\"/users/#{user1.id}/contact\">#{user1.email}</a>")
    expect(response.body).to include("<a href=\"/recipients/#{user2.recipient_id}\">#{user2.recipient.to_s}</a>")
    expect(response.body).to include("<a href=\"/users/#{user2.id}?approve=true\">Approve</a>")
  end

  it "as a normal user, does not list users" do
    sign_in(create(:user))
    get users_path
    expect(response).to have_http_status(:forbidden)
  end

  it "when not logged in, does not list users" do
    get users_path
    expect(response).to have_http_status(:forbidden)
  end
end
