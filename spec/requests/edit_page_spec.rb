# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'PATCH /:slug' do
  context 'when logged in as an admin' do
    before(:each) do
      sign_in(create(:user, :admin))
    end

    it 'updates the body and redirects back to slug' do
      page = create(:page)
      newbody = '<h3>new body</h3>'

      patch "/#{page.slug}", page: { body: newbody }, commit: 'Save'

      edited_page = Page.find(page.slug)
      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include(page.slug)
      expect(edited_page.body).to eq(newbody)
      expect(edited_page.title).to eq(page.title)
    end

    it 'redirects to changed slug when editing slug' do
      page = create(:page)
      newslug = 'newslug'

      patch "/#{page.slug}", page: { slug: newslug }, commit: 'Save'

      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to include(newslug)
    end

    it 'gets a edit page with ckeditor' do
      page = create(:page)

      get "/#{page.slug}/edit"

      expect(response).to have_http_status(:success)
      expect(response.body).to include('CKEDITOR')
    end

    it 'can change the owner' do
      user1 = create(:user)
      user2 = create(:user)

      page = create(:page, user: user1)

      patch "/#{page.slug}", page: { user_id: user2.id }, commit: 'Save'

      edited_page = Page.find(page.slug)
      expect(edited_page.user).to eq(user2)
    end
  end

  context 'when logged in as a regular user' do
    it 'can edit pages owned by that user' do
      user = create(:user)
      page = create(:page, user: user)
      newbody = '<h3>new body</h3>'

      sign_in(user)
      patch "/#{page.slug}", page: { body: newbody }, commit: 'Save'

      edited_page = Page.find_by_slug(page.slug)
      expect(edited_page.body).to eq(newbody)
    end

    it 'cannot change the owner' do
      user1 = create(:user)
      user2 = create(:user)
      page = create(:page, user: user1)

      sign_in(user1)
      patch "/#{page.slug}", page: { user_id: user2.id }, commit: 'Save'

      expect(response).to have_http_status(:forbidden)
      edited_page = Page.find(page.slug)
      expect(edited_page.user).to eq(user1)
    end
  end

  context 'when not logged in' do
    it 'cannot edit pages' do
      page = create(:page)
      newbody = '<h3>new body</h3>'

      patch "/#{page.slug}", page: { body: newbody }, commit: 'Save'

      expect(response).to have_http_status(:forbidden)
    end
  end
end
