# frozen_string_literal: true
# Base application controller
class ApplicationController < ActionController::Base
  helper_method :logo
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_exception|
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  def logo
    Rails.application.config.logo
  end
end
