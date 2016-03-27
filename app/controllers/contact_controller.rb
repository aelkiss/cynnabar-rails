class ContactController < ApplicationController
  # POST /user/contact
  def create
      
    feedback = params[:feedback]
    from_name = params[:from_name]
    from_email = params[:from_email]
    subject = params[:subject]

    ContactMailer.contact_email(contacted_thing,from_email,from_name,subject,feedback).deliver_later
  end

  # GET /user/contact
  def new
    @contacted_thing = contacted_thing
  end

  private

  def contacted_thing
    if params[:user_id].present?
      User.find(params[:user_id])
    elsif params[:office_id].present?
      Office.find(params[:office_id])
    else
      raise ActionController::ParameterMissing "office_id or user_id required"
    end
  end

end
