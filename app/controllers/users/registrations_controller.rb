class Users::RegistrationsController < Devise::RegistrationsController
  # prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  # prepend_before_action :set_minimum_password_length, only: [:new, :edit]

  

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.

  # def update
  #   self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #   prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  #   resource_updated = update_resource(resource, account_update_params)
  #   yield resource if block_given?
  #   if resource_updated
  #     if is_flashing_format?
  #       flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
  #         :update_needs_confirmation : :updated
  #       set_flash_message :notice, flash_key
  #     end
  #     bypass_sign_in resource, scope: resource_name
  #     respond_with resource, location: after_update_path_for(resource)
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end


  def update
    @updated = false
    
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if account_update_params[:email] != account_update_params[:confirm_email]
      resource.errors.add(:email, 'does not match')
      return
    end
    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      @updated = true
      # if is_flashing_format?
      #   flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
      #     :update_needs_confirmation : :updated
      #   set_flash_message :notice, flash_key
      # end
      bypass_sign_in resource, scope: resource_name
      flash.now[:success] = "You updated your email successfully, but we need to verify your new email address. Please check your email and follow the confirm link to confirm your new email address."
      # respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      # respond_with resource
    end
    # current_user.update(account_update_params)
  end

 

  protected

    def account_update_params
      params.require(:user).permit(:email, :confirm_email, :current_password)
    end

  
end