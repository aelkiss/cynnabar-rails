class ContactController < ApplicationController
  # POST /user/contact
  def create
    user = User.find!(params[:user])
    feedback = params[:feedback]
    from_name = params[:from_name]
    from_email = params[:from_email]
    subject = params[:subject]

    ContactMailer.contact_email(user,from_email,from_name,subject,feedback).deliver_later
  end

  # GET /user/contact
  def new
  end
end
