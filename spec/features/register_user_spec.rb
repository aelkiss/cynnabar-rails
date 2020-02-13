# frozen_string_literal: true
require 'rails_helper'

include ERB::Util

DEFAULT_USER_EMAIL = 'bob@example.com'

feature 'User registration', js: true do
  # must exist for user to have somewhere to get redirected back to
  before(:each) { create(:page, slug: 'home') }

  scenario 'can create an unconfirmed user' do
    visit '/users/sign_up'
    fill_in_user_details

    recipient = create(:recipient)
    fill_in 'user_name', with: recipient.to_s
    choose_autocomplete_result recipient.to_s, 'user_name'

    click_on 'Sign up'
    expect(page).to have_content('signed up successfully')
    user = User.find_by_email(DEFAULT_USER_EMAIL)
    expect(user).not_to be(nil)
    expect(user.approved).to be(false)
    expect(user.recipient_id).to eq(recipient.id)
  end

  scenario 'can create a user with a name and no recipient' do
    visit '/users/sign_up'
    fill_in_user_details
    fill_in 'user_name', with: 'Asdf Ghjkl'

    click_on 'Sign up'
    expect(page).to have_content('signed up successfully')

    user = User.find_by_email(DEFAULT_USER_EMAIL)
    expect(user).not_to be(nil)
    expect(user.approved).to be(false)
  end

  def fill_in_user_details
    fill_in 'user_email', with: DEFAULT_USER_EMAIL
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
  end
end

feature 'User approval', js: true do
  include_context 'when signed in through capybara'

  scenario 'can approve an unapproved user' do
    user = create(:user, approved: false)
    admin = create(:user, :admin)
    sign_in(admin)

    visit '/users'

    page.accept_alert 'Are you sure?' do
      find(:xpath, "//tr[td[a[contains(text(),'#{user.email}')]]]//a[contains(text(),'Approve')]").click
    end

    sleep(1)

    expect(current_path).to eq('/users')
    expect(User.find(user.id).approved).to be(true)
  end
end
