require 'rails_helper'

describe Page, "validations", type: :model do
  it { is_expected.to validate_uniqueness_of(:slug) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.not_to allow_values(nil).for(:slug) }
  it { is_expected.not_to allow_values('with spaces').for(:slug) }
  it { is_expected.not_to allow_values('Uppercase').for(:slug) }
  it { is_expected.not_to allow_values('special%characters').for(:slug) }
  it { is_expected.not_to allow_values('/leadingslash').for(:slug) }
  it { is_expected.to allow_values('it/has/some/slashes').for(:slug) }
end

describe Page, type: :model do
  it "is valid with attributes from factory" do
    page = build(:page)
    expect(page).to be_valid
  end

  it "is owned by an admin by default" do
    page = create(:page)
    expect(page.user.admin?).to be true
  end

  it "returns the slug as the url" do
    page = create(:page)
    expect(page.to_param).to eq("#{page.slug}")
  end

  it "raises an ActiveRecord::RecordNotFound for a nonexistent page" do
    expect { Page.find("nonexistent") }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can have an associated office" do
    page = build(:page, :office_page)
    expect(page).to be_valid
  end
end
