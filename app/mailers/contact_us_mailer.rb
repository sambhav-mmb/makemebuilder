class ContactUsMailer < ApplicationMailer

  def admin_email(name, email, phone, website, message, logo_path)
    @name = name
    @email = email
    @phone = phone
    @website = website
    @message = message
    @logo_path = logo_path
    mail(to: "support@makemebuilder.com", subject: "Contact Query")
  end

end