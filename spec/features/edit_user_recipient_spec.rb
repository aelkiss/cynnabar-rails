# frozen_string_literal: true
require 'rails_helper'

include ERB::Util

RSpec.feature 'Edit linked recipient' do
  include_context 'when signed in through capybara'

  scenario 'persists changes to the recipient' do
    recipient = create(:recipient, sca_name: 'Robert Exaumplemanne')
    user = create(:user, recipient: recipient)
    sign_in(user)

    click_link('Edit Profile', match: :first)

    fill_in 'recipient_title', with: 'Grand Poobah'
    fill_in 'recipient_pronouns', with: 'Its'
    fill_in 'recipient_sca_bio', with: 'Sample bio'
    click_on 'Update Profile'

    expect(page).not_to have_content('Group?')

    recipient = Recipient.find(user.recipient.id)

    expect(recipient.title).to eq('Grand Poobah')
    expect(recipient.pronouns).to eq('Its')

    expect(page).to have_content('Profile was successfully updated')
    expect(page).to have_content('Sample bio')
    expect(page).to have_content("Grand Poobah #{user.recipient.sca_name}")
  end
end
