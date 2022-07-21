# frozen_string_literal: true
require 'rails_helper'
require 'pry'

include ERB::Util

TEST_SUBJECT = 'Test subject'

RSpec.feature 'Contact email' do
  def send_mail(body = nil)
    subject = TEST_SUBJECT
    from = 'bob@example.com'
    from_name = 'Bob Exampleman'
    body ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    fill_in 'subject', with: subject
    fill_in 'from_email', with: from
    fill_in 'from_name', with: from_name
    fill_in 'feedback', with: body
    click_on 'Send'
  end

  # expect email to have been sent
  def expect_email_to(expected_whom)
    email = ActionMailer::Base.deliveries.last
    expect(email.to[0]).to eq(expected_whom)
    expect(email.subject).to match(TEST_SUBJECT)
  end

  def expect_page_with_back_link(expected_back)
    expect(page.body).to have_content('feedback has been sent')
    click_on 'Back'
    expect(page.current_path).to eq expected_back
  end

  def setup_office_contact
    office = create(:office, page: create(:page))
    visit page_path(office.page)
    click_on 'Contact'
    office
  end

  context 'when submitting empty feedback' do
    let(:message) { '' }

    before(:each) do 
      setup_office_contact
    end

    it 'does not send the mail' do
      expect { send_mail(message) }.not_to change(ActionMailer::Base.deliveries, :count)
    end

    it 'shows an error' do
      send_mail(message)
      expect(page.body).to have_content('Not sending email')
    end

    it 'does not say the mail was sent' do
      send_mail(message)
      expect(page.body).not_to have_content('feedback has been sent')
    end

    it 'stays on the same page' do
      contact_page = page.current_path
      send_mail(message)
      expect(page.current_path).to eq(contact_page)
    end

    it 'shows the contact form' do
      contact_page = page.current_path
      send_mail(message)
      expect(page.body).to have_selector("#feedback")
    end
  end


  scenario 'sends email to officer' do
    office = setup_office_contact
    send_mail
    expect_email_to(office.email)
    expect_page_with_back_link(page_path(office.page))
  end

  scenario 'sends email to user' do
    user = create(:user)
    page = create(:page, body: "Click <a href=\"#{user_contact_path(user)}\">here</a>")
    visit page_path(page)
    click_on 'here'
    send_mail
    expect_email_to(user.email)
    expect_page_with_back_link(page_path(page))
  end

  context "when verify_recaptcha returns false" do
    before(:each) do
      allow_any_instance_of(ContactController).to receive(:verify_recaptcha).and_return(false)
    end

    scenario 'does not send email' do
      setup_office_contact
      expect { send_mail }.not_to change(ActionMailer::Base.deliveries, :count)
    end
  end
end
