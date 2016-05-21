# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'DELETE /:slug' do
  context 'when logged in as an admin' do
    it 'allows deleting pages' do
      sign_in(create(:user, :admin))
      page = create(:page)

      delete page_path(page)

      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include pages_path
    end
  end

  context 'when not logged in' do
    it 'does not allow deleting pages' do
      page = create(:page)

      delete page_path(page)

      expect(response).to have_http_status(:forbidden)
    end
  end
end
