require 'rails_helper'

RSpec.describe Office, type: :model do
  it "requires a name" do
    office = build(:office, name: nil)
    expect(office).not_to be_valid
  end

  it "requires an email address" do
    office = build(:office, email: nil)
    expect(office).not_to be_valid
  end

  it "requires an image" do
    office = build(:office, image: nil)
    expect(office).not_to be_valid
  end

  context "when there is no officer" do
    it "is valid" do
      office = build(:office, officer: nil)
      expect(office).to be_valid
    end

    it "returns (Vacant) for the officer name" do
      office = build(:office, officer: nil)
      expect(office.officer_name).to eq("(Vacant)")
    end
  end

  context "when there is an officer" do
    it "returns the officer name" do
      officer = create(:user, name: 'Bob Bobberts')
      office = build(:office, officer: officer)
      expect(office.officer_name).to eq(officer.name)
    end
  end

  pending "add some examples to (or delete) #{__FILE__}"
end
