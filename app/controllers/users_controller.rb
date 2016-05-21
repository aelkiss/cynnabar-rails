# frozen_string_literal: true
# Controller for user display & editing
class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @approved_users = User.where(approved: true).order(:email)
    @unapproved_users = User.where(approved: false).order(:email)
  end

  def show
  end

  def update
    authorize! :manage, @user if user_params[:role] || user_params[:approved]
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:email, :name, :approved, :role)
  end

  private

  def authorize_manage(user_params, field)
    authorize! :manage, @user if user_params[field]
  end
end
