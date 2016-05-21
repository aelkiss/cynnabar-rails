require 'rails_helper'

include ERB::Util

RSpec.feature 'Edit linked recipient' do
  include_context 'when signed in through capybara'

  scenario 'persists changes to the recipient' do
    user = create(:user, :has_recipient)
    sign_in(user)

    click_link('Edit Profile', match: :first)

    fill_in 'recipient_title', with: 'Grand Poobah'
    fill_in 'recipient_pronouns', with: 'Its'
    click_on 'Update Profile'

    expect(page).not_to have_content('Group?')

    recipient = Recipient.find(user.recipient.id)

    expect(recipient.title).to eq('Grand Poobah')
    expect(recipient.pronouns).to eq('Its')

    expect(page).to have_content('Profile was successfully updated')
  end
end
