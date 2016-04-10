class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @approved_users = User.where(approved: true).order(:email)
    @unapproved_users = User.where(approved: false).order(:email)
  end
end
