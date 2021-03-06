# frozen_string_literal: true
require 'rails_helper'
require 'pry'

include ERB::Util

describe 'GET /:slug' do
  it 'gets the right page' do
    page = create(:page)

    get page_path(page)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(page.body)
    expect(response.body).to include("<title>#{page.title}</title>")
  end

  context 'when the slug includes a /' do
    it 'works' do
      page = create(:page, slug: 'it/has/some/slashes')
      get page_path(page)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(page.body)
      expect(response.body).to include("<title>#{page.title}</title>")
    end
  end

  it 'shows the cynnabar logo by default' do
    page = create(:page)
    get page_path(page)
    expect(response.body).to include('cynnabar_logo.gif')
  end

  it 'can show a custom logo' do 
    page = create(:page, logo: 'other_logo.gif')
    get page_path(page)
    expect(response.body).to include('other_logo.gif')
  end

  it 'can show the terpsichore menu' do
    page = create(:page, menu: 'layouts/terpsichore_menu')
    get page_path(page)
    expect(response.body).to include('Schedule')
  end

  # TODO: move to view tests?
  context 'when logged in as a regular user' do
    it 'shows an edit link for pages owned by that user' do
      user = create(:user)
      page = create(:page, user: user)

      sign_in(user)
      get page_path(page)

      expect(response.body).to include(edit_page_path(page))
    end

    it 'does not show an edit link for pages not owned by that user' do
      user = create(:user)
      page = create(:page)

      sign_in(user)
      get page_path(page)

      expect(response.body).not_to include(edit_page_path(page))
    end

    it 'does not show an index link' do
      user = create(:user)
      page = create(:page)

      sign_in(user)
      get page_path(page)

      expect(response.body).not_to include(pages_path)
    end
  end

  context 'when logged in as an admin' do
    it 'always shows an edit link' do
      user = create(:user, :admin)
      page = create(:page)

      sign_in(user)
      get page_path(page)

      expect(response.body).to include(edit_page_path(page))
    end

    it 'shows a list pages link' do
      user = create(:user, :admin)
      page = create(:page)

      sign_in(user)
      get page_path(page)

      expect(response.body).to include(pages_path)
    end
  end
end

describe 'GET /' do
  it "shows the page with slug 'home'" do
    page = create(:page, slug: 'home')

    get '/'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(page.body)
  end
end
