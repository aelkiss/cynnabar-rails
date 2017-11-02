# frozen_string_literal: true
require 'rails_helper'
require 'pry'

include ERB::Util

feature 'Create awarding', js: true do
  include_context 'when signed in through capybara'

  scenario 'saves the receipt' do
    sign_in(create(:user, :herald))
    recipient = create(:recipient)
    award = create(:award, :hasgroup)

    visit '/awardings/new'
    binding.pry
    fill_in 'recipient_name', with: recipient.to_s
    choose_autocomplete_result recipient.to_s, 'recipient_name'
    fill_in 'award_name', with: award.name
    choose_autocomplete_result award.name, 'award_name'
    fill_in 'awarding_received', with: '1970-01-01'

    click_on 'Submit'

    expect(page).to have_content('Awarding was successfully created')

    awarding = Awarding.first
    expect(awarding.award_id).to eq(award.id)
    expect(awarding.recipient_id).to eq(recipient.id)
  end
end
