# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  prepend_before_action :check_captcha, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:recipient_id, :name])
  end

  def build_resource(hash = nil)
    hash ||= {}
    super
    if hash[:recipient_id].present?
      recipient = Recipient.find(hash[:recipient_id])
      # recipient must have either sca or mundane name. preferentially use sca name
      resource.name = recipient.sca_name
      resource.name ||= recipient.mundane_name
      resource.recipient = recipient
    else
      resource.name = hash[:name]
    end
  end

  def check_captcha
    if verify_recaptcha
      true
    else
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
