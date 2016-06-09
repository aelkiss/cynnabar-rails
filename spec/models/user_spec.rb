require "rails_helper"
# frozen_string_literal: true
describe User, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

  it "validates uniqueness of recipient" do
    r = create(:recipient)
    create(:user, recipient: r)
    expect(build(:user, recipient: r)).not_to be_valid
  end

  it "allows two non-nil users" do
    create(:user)
    expect(build(:user)).to be_valid
  end
end
