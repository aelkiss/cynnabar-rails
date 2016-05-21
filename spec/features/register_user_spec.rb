require 'rails_helper'

include ERB::Util

feature 'User registration', js: true do
  scenario 'can create an unconfirmed user' do
    recipient = create(:recipient)
    page = create(:page, slug: 'home')
    visit '/users/sign_up'
    fill_in 'user_email', with: 'bob@exampleman.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    fill_in 'user_name', with: recipient.to_s
    choose_autocomplete_result recipient.to_s, 'user_name'

    click_on 'Sign up'

    user = User.find_by_email('bob@exampleman.com')
    expect(user).not_to be(nil)
    expect(user.recipient_id).to eq(recipient.id)
    expect(user.approved).to be(false)
  end
end

feature 'User approval' do
  include_context 'when signed in through capybara'

  scenario 'can approve an unapproved user' do
    user = create(:user, approved: false)
    admin = create(:user, :admin)
    sign_in(admin)

    click_on 'List Users', match: :first
    find(:xpath, "//tr[td[a[contains(text(),'#{user.email}')]]]//a[contains(text(),'Approve')]").click

    expect(User.find(user.id).approved).to be(true)
  end
end
