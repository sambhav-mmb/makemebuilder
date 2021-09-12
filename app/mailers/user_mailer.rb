class UserMailer < ApplicationMailer

	 def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

	def user_reject(user)
    @user = user
    mail(to: @user[:email], subject: @user[:first_name])
  end
  
  def user_approved(user)
    @user = user
    mail(to: @user[:email], subject: @user[:first_name])
  end 

  def checkout_mail(user, order)
    @user = user
    @order = order
    attachments["order_#{@order.id}.pdf"] = {mimi_type: "application/pdf", content: File.read(Rails.root.join('pdfs', "order_#{@order.id}.pdf"))}
    mail(to: @user[:email], subject: "Confirmation of your enquiry at Make Me Builder")
  end

  def checkoutadmin_mail(user, order)
    @user = user
    @order = order
    attachments["order_#{@order.id}.pdf"] = {mimi_type: "application/pdf", content: File.read(Rails.root.join('pdfs', "order_#{@order.id}.pdf"))}
    mail(to: "support@makemebuilder.com", subject: "Enquiry from #{@user.name}, #{@order.id}")
  end

  def under_review_mail(user)
    @user = User.last
    mail(to: @user[:email], subject: @user[:first_name])
  end

  def under_review_maill(user)
    @adminuser = AdminUser.last
    mail(to: "support@makemebuilder.com", subject: "Profile Submittion")
  end
end
