# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'pages/edit', type: :view do
  it 'has an option for selecting the owner' do
    @page = assign(:page, create(:page))
    admin = build(:user, :admin)
    allow(controller).to receive(:current_ability).and_return(Ability.new(admin))
    user = create(:user)
    render
    assert_select 'option', text: user.to_s
  end
end
