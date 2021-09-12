class QuoteMailer < ApplicationMailer

  def user_email(full_name, email, logo_path)
    @full_name = full_name
    @email = email
    @logo_path = logo_path
    mail(to: @email, subject: "Quote Request Submitted to Make Me Builder")
  end

  def admin_email(custom_quote, logo_path)
    @custom_quote = custom_quote
    @name = custom_quote.name
    @email = custom_quote.email
    @phone = custom_quote.phone
    @category = custom_quote.category.name
    @comment = custom_quote.comment
    @details = custom_quote.details
    @logo_path = logo_path
    mail(to: "support@makemebuilder.com", subject: "Quote Request")
  end

end