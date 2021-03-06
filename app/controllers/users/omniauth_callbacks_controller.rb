class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # def facebook
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.from_omniauth(request.env['omniauth.auth'])
        if @user.persisted?
          # sign_in_and_redirect @user, event: :authentication
          sign_in @user
          redirect_to "/"
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          flash[:errors] = @user.errors
          session["devise.#{provider}_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end
# # app/controllers/users/omniauth_callbacks_controller.rb:

# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def google_oauth2
#       # You need to implement the method below in your model (e.g. app/models/user.rb)
#       @user = User.from_omniauth(request.env['omniauth.auth'])

#       if @user.persisted?
#         flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
#         sign_in_and_redirect @user, event: :authentication
#       else
#         session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
#         redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
#       end
#   end
# end

# def self.from_omniauth(access_token)
#     data = access_token.info
#     user = User.where(email: data['email']).first

#     # Uncomment the section below if you want users to be created if they don't exist
#     # unless user
#     #     user = User.create(name: data['name'],
#     #        email: data['email'],
#     #        password: Devise.friendly_token[0,20]
#     #     )
#     # end
#     user
# end
  [:google_oauth2, :facebook, :linkedin].each do |provider|
    provides_callback_for provider
  end


  def failure
    redirect_to root_path
  end

end