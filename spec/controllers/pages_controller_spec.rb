require 'rails_helper'

describe PagesController, type: :controller do
  describe '#page_path' do
    it 'is /:slug' do
      page = create(:page)
      expect(page_path(page)).to eq "/#{page.slug}"
    end

    it 'does not urlencode when there are slashes' do
      slug = 'there/are/slashes'
      page = create(:page, slug: slug)
      expect(page_path(page)).to eq "/#{slug}"
    end
  end

  describe '#page_edit_path' do
    it 'is /:slug/edit' do
      page = create(:page)
      expect(edit_page_path(page)).to eq "/#{page.slug}/edit"
    end
  end

  describe '#new_page_path' do
    it 'is /pages/new' do
      expect(new_page_path).to eq '/pages/new'
    end
  end

  describe '#pages_path' do
    it 'is /pages' do
      expect(pages_path).to eq '/pages'
    end
  end
end
