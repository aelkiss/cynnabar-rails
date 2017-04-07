# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ContactController, type: :controller do
  it "returns success with a user id" do
    user = create(:user)
    get(:new, user_id: user.id)
    expect(response).to have_http_status(:success)
  end
end
