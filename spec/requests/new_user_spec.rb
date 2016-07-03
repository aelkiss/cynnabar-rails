# frozen_string_literal: true
require 'rails_helper'
require 'pry'

describe 'POST /users' do
  it 'does not create a user without recaptcha' do
    Recaptcha.configuration.skip_verify_env.delete('test')
    user = attributes_for(:user)
    expect do
      post '/users', user: user, commit: 'Save'
    end.not_to change(User, :count)
  end
end