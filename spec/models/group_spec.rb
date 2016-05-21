# frozen_string_literal: true
describe Group, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end
