# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'PATCH /office/:office_id' do
  context 'when logged in as an admin' do
    before(:each) { sign_in(create(:user, :admin)) }

    it 'can edit the office' do
      office = create(:office)
      newname = 'new name'
      path = office_path(office)

      patch path, office: { name: newname }

      edited_office = Office.find(office.id)
      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include page_path(office.page)
      expect(edited_office.name).to eq(newname)
    end
  end

  context 'when logged in as a regular user' do
    before(:each) { sign_in(create(:user)) }
    it { cannot_edit_offices }
  end

  context 'when not logged in' do
    it { cannot_edit_offices }
  end
end

def cannot_edit_offices
  office = create(:office)
  patch office_path(office), office: { name: 'newname' }
  expect(response).to have_http_status(:forbidden)
end
