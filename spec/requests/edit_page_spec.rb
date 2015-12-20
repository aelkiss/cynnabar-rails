require 'rails_helper'
require 'pry'

describe "When editing a page" do
  it "updates the body" do
    page = create(:page)
    newbody = "<h3>akljshdfkaljshdflkajsdhf</h3>"

    patch "/#{page.slug}", page: {body: newbody}

    edited_page = Page.find_by_slug(page.slug)
    expect(edited_page.body).to eq(newbody)
    expect(edited_page.title).to eq(page.title)
  end

  it "gets a edit page with ckeditor" do
    page = create(:page)

    get "/#{page.slug}/edit"

    expect(response.status).to eq(200)
    expect(response.body).to include('ckeditor')
  end

  it "allows previewing the edit" do
    page = create(:page)
    newbody = "<h3>akljshdfkaljshdflkajsdhf</h3>"

    get "/#{page.slug}/edit", page: {body: newbody}

    expect(response.status).to eq(200)
    expect(response.body).to include(newbody)
  end

  it "doesn't update when previewing" do
    page = create(:page)
    newbody = "<h3>akljshdfkaljshdflkajsdhf</h3>"

    get "/#{page.slug}/edit", page: {body: newbody}

    samepage = Page.find_by_slug(page.slug)
    expect(samepage.body).to eq(page.body)
  end

end
