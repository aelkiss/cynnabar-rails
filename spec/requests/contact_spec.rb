# frozen_string_literal: true
require 'rails_helper'

describe 'GET office/:id/contact' do
  it 'shows the name when contacting an office' do
    office = create(:office)
    get office_contact_path(office)
    expect(response.body).to include(office.name)
  end
end

describe 'GET user/:id/contact' do
  it "shows the user's name when contacting a user" do
    user = create(:user, name: 'Bob Exampleman')
    get user_contact_path(user)
    expect(response.body).to include(user.name)
  end
end
