require 'rails_helper'
require 'pry'

include ERB::Util

RSpec.feature "Adding heradry" do
  include_context "when signed in through capybara"
  before(:each) do
    sign_in(create(:user, :admin))
  end

  def attach_heraldry(edit_path,view_path,save_button)
    visit edit_path
    attach_file "Heraldry", "spec/assets/heraldry.gif"
    click_on save_button

    visit view_path
    expect(page).to have_selector("img.heraldry")
  end

  scenario "adds heraldry to recipient" do
    new_recipient = create(:recipient, :sca)
    attach_heraldry(edit_recipient_path(new_recipient),recipient_path(new_recipient),'Update Profile')
  end

  scenario "adds heraldry to award" do
    new_award = create(:award)
    attach_heraldry(edit_award_path(new_award),award_path(new_award),'Update Award')
  end

end
