# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'pages/edit', type: :view do
  before(:each) do
    @page = assign(:page, create(:page))
    admin = build(:user, :admin)
    allow(controller).to receive(:current_ability).and_return(Ability.new(admin))
  end

  it 'has an option for selecting the owner' do
    user = create(:user)
    render
    assert_select 'option', text: user.to_s
  end

  it 'has an option for adding a custom logo' do
    render
    assert_select "input[name='page[logo]']"
  end

  it 'has an option for adding a custom menu' do
    render
    assert_select "input[name='page[menu]']"
  end
end
