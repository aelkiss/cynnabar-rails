# frozen_string_literal: true
require 'rails_helper'

describe Award, type: :model do
  context 'when given a normal award' do
    subject { build(:award) }
    it { is_expected.to be_valid }
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.not_to allow_value('too short').for(:description) }
  it { is_expected.to validate_presence_of(:precedence) }
  it { is_expected.to allow_value(build(:group)).for(:group) }
  it { is_expected.not_to validate_presence_of(:group) }

  it do
    is_expected.to validate_attachment_content_type(:heraldry)
      .allowing('image/png', 'image/jpeg', 'image/gif')
      .rejecting('text/plain', 'application/octet-stream', 'application/pdf')
  end

  it { should validate_attachment_size(:heraldry).less_than(500.kilobytes) }

  describe '#to_s' do
    it 'returns the name' do
      award = build(:award)
      expect(award.to_s).to eq(award.name)
    end
  end
end
