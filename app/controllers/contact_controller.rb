# frozen_string_literal: true
class ContactController < ApplicationController
  # POST /user/contact
  def create
    if verify_recaptcha
      clean_referring_page
      contact_user
    else
      render 'new'
    end
  end

  # GET /user/contact
  def new
    @contacted_thing = contacted_thing
    @back_link = request.referrer
  end

  private

  def contacted_thing
    if params[:user_id].present?
      User.find(params[:user_id])
    elsif params[:office_id].present?
      Office.find(params[:office_id])
    else
      raise ActionController::ParameterMissing 'office_id or user_id required'
    end
  end

  def clean_referring_page
    @referring_page = params[:referring_page]
    # reject it if it isn't on this site
    @referring_page = nil unless @referring_page.match("^#{root_url}")
  end

  def contact_user
    @contacted_thing = contacted_thing
    if(params[:feedback].present?) 
      ContactMailer.contact_email(@contacted_thing, params[:from_email],
                                  params[:from_name], params[:subject],
                                  params[:feedback]).deliver_later
    else
      flash.alert = "Not sending email - feedback must be present"
      render 'new'
    end
  end
end
