class GetInTouchMailer < ApplicationMailer

  def user_email(email, logo_path)
    @email = email
    @logo_path = logo_path
    mail(to: @email, subject: "Get In Touch")
  end

  def admin_email(email, logo_path)
    @email = email
    @logo_path = logo_path
    mail(to: "news@makemebuilder.com", subject: "Get In Touch")
  end

end