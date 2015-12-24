require 'rails_helper'
require 'pry'

describe "PATCH /:slug" do
  include_context "when using devise/warden auth"
  context 'when logged in as an admin' do 
    before(:each) { sign_in(create(:user, :admin)) }

    it "can edit the office" do
      office = create(:office)
      newname = "new name"
      path = url_for(office)

      patch path, office: {name: newname}

      edited_office = Office.find(office.id)
      expect(response.status).to eq(302)
      expect(response.redirect_url).to include(path)
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
  patch url_for(office), office: {name: 'newname'}
  expect(response.status).to eq(403)
end

