require 'rails_helper'

describe Awarding, type: :model do
  it { is_expected.to validate_presence_of(:award) }
  it { is_expected.to validate_presence_of(:recipient) }

  context "with a normal award" do
    subject(:awarding) { build(:awarding) }

    it { is_expected.to be_valid }

    it "has a default group" do
      expect(awarding.group.to_s).to eq(awarding.award.group.to_s)
    end

    it "does not allow overriding award name" do
      awarding.award_name = 'override'
      expect(awarding).not_to be_valid
    end

    it "returns (Unknown) for the date" do
      expect(awarding.received).to eq '(Unknown)'
    end
  end

  it "can have award text" do
    awarding = build(:awarding, award_text: "Lorem ipsum dolor")
    expect(awarding).to be_valid
  end

  it "is valid with an award name and group if it is an 'other' award" do
    awarding = build(:awarding, :other)
    expect(awarding).to be_valid
  end

  it "must have a group if the award does not" do
    awarding = build(:awarding, :other, group: nil)
    expect(awarding).not_to be_valid
  end

  it "can return overriden group" do
    groupname = 'different group'
    award = build(:awarding, group: create(:group, name: groupname))
    expect(award.group.to_s).to eq(groupname)
  end

  describe '#to_s' do
    it "returns overriden award name" do
      othername = 'overridden name'
      awarding = build(:awarding, :other, award_name: othername, group: nil)
      expect(awarding.to_s).to eq(othername)
    end

    it "returns default award name if not overridden" do
      awarding = build(:awarding, award_name: nil)
      expect(awarding.to_s).to eq(awarding.award.name)
    end

    it "appends awarding group to award name if not the default" do
      groupname = 'different group'
      awarding = build(:awarding, group: create(:group, name: groupname)) 
      expect(awarding.to_s).to eq "#{awarding.award.name} (#{groupname})"
    end

    it "returns the date in YYYY-MM-DD format if given"do
      awarding = build(:awarding, received: Date.new(1981,2,1))
      expect(awarding.received.to_s).to eq "1981-02-01"
    end
  end

end

