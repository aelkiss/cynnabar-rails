# frozen_string_literal: true
require 'rails_helper'
require 'cancan/matchers'

describe 'Ability' do
  context 'when the user is a normal user' do
    let(:user) { create(:user, :has_recipient) }
    subject { Ability.new(user) }

    context 'when the user has a recipient' do
      it { is_expected.to be_able_to(:edit, user.recipient) }
    end

    context 'when the user has a page they own' do
      let(:page) { build(:page, user: user) }

      it { is_expected.to be_able_to(:edit, page) }
      it { is_expected.to be_able_to(:update, page) }
    end

    context 'when there is a page owned by another user' do
      let(:page) { build(:page, user: create(:user)) }
      it { is_expected.not_to be_able_to(:edit, page) }
      it { is_expected.not_to be_able_to(:update, page) }
    end

    it { is_expected.not_to be_able_to(:edit, build(:office)) }
    it { is_expected.not_to be_able_to(:show, build(:office)) }

    [:edit, :create, :destroy].each do |operation|
      [:award, :recipient, :awarding].each do |type|
        it "is not able to #{operation} #{type}s" do
          is_expected.not_to be_able_to(operation, build(type))
        end
      end
    end
  end

  context 'when the user is an admin' do
    subject { Ability.new(create(:user, :admin)) }

    context 'when there is a page owned by another user' do
      let(:page) { build(:page, user: create(:user)) }

      it { is_expected.to be_able_to(:edit, page) }
      it { is_expected.to be_able_to(:update, page) }
    end

    it { is_expected.to be_able_to(:manage, build(:office)) }
    it { is_expected.to be_able_to(:manage, build(:recipient)) }
    it { is_expected.to be_able_to(:manage, build(:awarding)) }
    it { is_expected.to be_able_to(:manage, build(:award)) }
  end

  context 'when the user is anonymous' do
    subject { Ability.new(nil) }
    it { is_expected.to be_able_to(:index, Office) }
    it { is_expected.to be_able_to(:show, build(:page)) }
  end

  context 'when the user is a herald' do
    subject { Ability.new(create(:user, :herald)) }

    it { is_expected.to be_able_to(:create, Recipient) }
    it { is_expected.to be_able_to(:edit, build(:recipient)) }
    it { is_expected.to be_able_to(:manage, build(:awarding)) }
    it { is_expected.not_to be_able_to(:manage, build(:award)) }
    it { is_expected.not_to be_able_to(:manage, build(:page)) }
    it { is_expected.not_to be_able_to(:manage, build(:office)) }
  end

  context 'when the user is not approved' do
    let(:user) { create(:user, :has_recipient, approved: false) }
    subject { Ability.new(user) }

    it { is_expected.not_to be_able_to(:edit, user.recipient) }
    it { is_expected.not_to be_able_to(:edit, build(:page, user: user)) }
  end
end
