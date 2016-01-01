describe Award, type: :model do
  context "when given a normal award" do
    subject { build(:award) }
    it { is_expected.to be_valid }
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.not_to allow_value('too short').for(:description) }
  it { is_expected.to validate_presence_of(:precedence) }
  it { is_expected.to allow_value(build(:group)).for(:group) }
  it { is_expected.not_to validate_presence_of(:group) }

  describe "#to_s" do
    it "returns the name" do
      award = build(:award)
      expect(award.to_s).to eq(award.name)
    end
  end
end
