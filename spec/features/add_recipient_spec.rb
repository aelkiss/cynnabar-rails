require 'rails_helper'

include ERB::Util

RSpec.feature 'Create recipient' do
  include_context 'when signed in through capybara'

  scenario 'saves the receipt' do
    sign_in(create(:user, :herald))

    expect do
      visit '/recipients/new'
      fill_in 'recipient_sca_name', with: 'Bob Exampleman'

      click_on 'Create Profile'
    end.to change { Recipient.count }.from(0).to(1)

    expect(page).to have_content('Profile was successfully created')
  end
end
