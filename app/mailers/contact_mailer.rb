class ContactMailer < ApplicationMailer
  def contact_email(user,reply_to,subject,feedback)
    @feedback = feedback
    mail(to: user.email, subject: "Contact from cynnabar.org: #{subject}", reply_to: reply_to)
  end
end
