# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'POST /users' do
  before(:each) do
    allow_any_instance_of(Users::RegistrationsController).to receive(:verify_recaptcha).and_return(false)
  end

  it 'does not create a user without recaptcha' do
    user = attributes_for(:user)
    expect do
      post '/users', params: { user: user, commit: 'Save' }
    end.not_to change(User, :count)
  end
end
