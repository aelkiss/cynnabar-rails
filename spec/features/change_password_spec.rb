require 'rails_helper'
require 'pry'

include ERB::Util

RSpec.feature 'Users' do
  scenario 'can change password' do
    # ensure there is a home page
    create(:page, slug: 'home')
    user = create(:user)
    newpass = 'newpassword'

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'

    click_on('User', match: :first)
    click_on('Change Password', match: :first)
    fill_in 'user_current_password', with: user.password
    fill_in 'user_password', with: newpass
    fill_in 'user_password_confirmation', with: newpass
    click_on('Update')
    click_on('Logout', match: :first)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: newpass
    click_on 'Log in'

    # should get redirected to home page
    expect(page.current_path).to eq '/'
    expect(page).not_to have_content 'Invalid email or password.'
  end
end
