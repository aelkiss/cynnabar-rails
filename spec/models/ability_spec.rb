require 'rails_helper'
require 'cancan/matchers'

describe "Ability" do
  it "allows users to edit their own pages" do
    user = create(:user)
    page = create(:page, user: user)
    ability = Ability.new(user)

    expect(ability).to be_able_to(:edit, page)
    expect(ability).to be_able_to(:update, page)
  end

  it "does not allow users to edit other user's pages" do
    user1 = create(:user)
    user2 = create(:user)
    page = create(:page, user: user2)
    ability = Ability.new(user1)

    expect(ability).not_to be_able_to(:edit, page)
    expect(ability).not_to be_able_to(:update, page)
  end

  it "allows admins to edit other user's pages" do
    admin = create(:user, :admin)
    page = create(:page, user: create(:user))
    ability = Ability.new(admin)

    expect(ability).to be_able_to(:edit, page)
    expect(ability).to be_able_to(:update, page)
  end

  it "allows admins to edit offices" do
    ability = Ability.new(create(:user, :admin))
    office = create(:office)
    expect(ability).to be_able_to(:edit, office)
  end

  it "allows anyone to list offices" do
    ability = Ability.new(nil)
    expect(ability).to be_able_to(:index, Office)
  end

  it "does not allow regular users to edit offices" do
    ability = Ability.new(create(:user))
    office = create(:office)
    expect(ability).not_to be_able_to(:edit, office)
  end

  it "does not allow regular users to render offices directly" do
    ability = Ability.new(create(:user))
    office = create(:office)
    expect(ability).not_to be_able_to(:show, office)
  end
end
