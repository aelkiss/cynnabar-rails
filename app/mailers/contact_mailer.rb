# frozen_string_literal: true
class ContactMailer < ApplicationMailer
  def contact_email(user, from_email, from_name, subject, feedback)
    @feedback = feedback
    @from_name = from_name
    @from_email = from_email
    if feedback
      mail(to: user.email, subject: "Contact from cynnabar.org: #{subject}", reply_to: from_email)
    end
  end
end
