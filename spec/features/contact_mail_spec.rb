require 'rails_helper'
require 'pry'

include ERB::Util

RSpec.feature "Contact email" do

  def send_and_expect_email(expected_whom)
    subject = 'This is the subject'
    from = 'bob@example.com'
    from_name = 'Bob Exampleman'
    body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    fill_in "subject", with: subject
    fill_in "from_email", with: from
    fill_in "from_name", with: from_name
    fill_in "feedback", with: body
    click_on "Send"

    # expect email to have been sent
    email = ActionMailer::Base.deliveries.last
    expect(email.to[0]).to eq(expected_whom)
    expect(email.subject).to match(subject)
    # asset reply to and body as well
  end

  scenario "sends email to officer" do
    office = create(:office, page: create(:page))
    visit page_path(office.page)
    click_on "Contact"
    send_and_expect_email(office.email)
  end

  scenario "sends email to user" do
    user = create(:user)
    visit user_contact_path(user)
    send_and_expect_email(user.email)
  end

end
