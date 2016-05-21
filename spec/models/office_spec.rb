# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Office, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to validate_presence_of(:page) }
  it { is_expected.not_to validate_presence_of(:officer) }

  context 'when there is no officer' do
    it 'returns (Vacant) for the officer name' do
      office = build(:office, officer: nil)
      expect(office.officer_name).to eq('(Vacant)')
    end
  end

  context 'when there is an officer' do
    it 'returns the officer name' do
      officer = create(:user, name: 'Bob Bobberts')
      office = build(:office, officer: officer)
      expect(office.officer_name).to eq(officer.name)
    end
  end
end
