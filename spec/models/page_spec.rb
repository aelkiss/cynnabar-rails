require 'rails_helper'

RSpec.describe Page, type: :model do
  it "is valid with attributes from factory" do
    page = build(:page)
    expect(page).to be_valid
  end

  it "does not allow spaces in slug" do
    page = build(:page, slug: 'invalid slug')
    expect(page).not_to be_valid
  end

  it "does not allow uppercase characters in slug" do
    page = build(:page, slug: 'InvalidSlug')
    expect(page).not_to be_valid
  end

  it "does not allow special characters in slug" do
    page = build(:page, slug: 'invalid%slug')
    expect(page).not_to be_valid
  end

  it "does not allow leading / in the slug" do
    page = build(:page, slug: '/leadingslash')
    expect(page).not_to be_valid
  end

  it "requires a slug" do
    page = build(:page, slug: nil)
    expect(page).not_to be_valid
  end

  it "requires a body" do
    page = build(:page, body: nil)
    expect(page).not_to be_valid
  end

  it "requires a title" do
    page = build(:page, title: nil)
    expect(page).not_to be_valid
  end

  it "does not allow two pages with the same slug" do
    page = create(:page, slug: 'slug')
    anotherpage = build(:page, slug: 'slug')
    # should it be invalid or raise an error??
    expect(anotherpage).not_to be_valid
  end

  it "returns the slug as the url" do
    page = create(:page)
    expect(page.to_param).to eq("#{page.slug}")
  end
end
