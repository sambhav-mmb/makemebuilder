class NewsLetterMailer < ApplicationMailer

  def user_email(news_letter)
    @news_letter = news_letter
    # @logo_path = logo_path
    mail(to: @news_letter.email, subject: "Subscribed to News Letter")
  end

  def admin_email(news_letter)
    @news_letter = news_letter
    # @email = email
    # @logo_path = logo_path
    mail(to: "news@makemebuilder.com", subject: "User subscribed to News Letter")
  end

end