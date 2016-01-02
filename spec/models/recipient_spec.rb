describe Recipient, type: :model do
  it "is valid with only sca name" do
    recipient = build(:recipient, sca_name: 'sca name', mundane_name: nil)
    expect(recipient).to be_valid
  end

  it "is valid with only mundane name" do
    recipient = build(:recipient, sca_name: nil, mundane_name: 'Mundane name')
    expect(recipient).to be_valid
  end

  it "is not valid with neither mundane & sca name" do
    recipient = build(:recipient, sca_name: nil, mundane_name: nil)
    expect(recipient).not_to be_valid
  end

  it "does not allow groups to have a mundane name" do
    recipient = build(:recipient, :group, mundane_name: 'Mundane name')
    expect(recipient).not_to be_valid
  end

  it "is allowed to be a group" do
    recipient = build(:recipient, :group)
    expect(recipient).to be_valid
  end

  it "allows FKA (Formerly known as)" do
    recipient = build(:recipient,formerly_known_as: 'Formerly Jones')
    expect(recipient).to be_valid
  end

  it "allows AKA (Formerly known as)" do
    recipient = build(:recipient,also_known_as: 'Beef Johnson')
    expect(recipient).to be_valid
  end

  describe '#to_s' do
    it "gives both SCA and mundane name if both exist" do
      sca_name = 'SCA name'
      mundane_name = 'mundane name'
      recipient = build(:recipient, sca_name: sca_name, mundane_name: mundane_name)
      expect(recipient.to_s).to eq("#{sca_name} (modernly known as #{mundane_name})")
    end
    
    it "gives only sca name if mundane name is missing" do
      sca_name = 'SCA name'
      recipient = build(:recipient, sca_name: sca_name, mundane_name: nil)
      expect(recipient.to_s).to eq(sca_name)
    end

    it "gives only mundane name if sca name is missing" do
      mundane_name = 'mundane name'
      recipient = build(:recipient, sca_name: nil, mundane_name: mundane_name)
      expect(recipient.to_s).to eq(mundane_name)
    end

    it "indicates a group is a group" do
      recipient = build(:recipient, :group)
      expect(recipient.to_s).to match(/\(Group\)$/)
    end

    it "shows the formerly known as" do
      recipient = build(:recipient, :othernames)
      expect(recipient.to_s).to match(/ \(formerly known as #{recipient.formerly_known_as}\)/)
    end

    it "does not known the FKA block if not needed" do
      recipient = build(:recipient)
      expect(recipient.to_s).not_to match(/ \(formerly known as /)
    end

    it "nulls out mundane name if it is set to empty string" do
      recipient = build(:recipient)
      recipient.mundane_name = ""
      expect(recipient.mundane_name).to be(nil)
    end

    it "nulls out sca name if it is set to empty string" do
      recipient = build(:recipient)
      recipient.sca_name = ""
      expect(recipient.sca_name).to be(nil)
    end
  end
end
