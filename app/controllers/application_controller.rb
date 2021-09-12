class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_exception_notifier

  helper_method :user_current_vendor?
  helper_method :current_dashboard_type
  helper_method :current_cart
  helper_method :recently_viewed_products


  def user_current_vendor?
  	params[:user_type] == "vendor"
  end

  def current_dashboard_type
  	return "Partner" if user_current_vendor? && current_user.is_vendor?
  	return "User"
  end

  def current_cart
    if user_signed_in?
      @cart = Cart.where(user_id: current_user.id, is_ordered: false).last
      unless @cart.present?
        @cart = Cart.create(user_id: current_user.id)
      end
    end
    return @cart
  end

  def recently_viewed_products
    if user_signed_in?
      recent_products = current_user.recent_products
    else
      recent_products = RecentProduct.where(session_id: session.id)
    end
    return Product.where(id: recent_products.map(&:product_id))
  end

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :company_name, :username, :email, :mobile, :country_code, :secondary_email])
	  end

	  def after_sign_in_path_for(resource)
      request.env['omniauth.origin'] || stored_location_for(resource) || dashboard_path
    end

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => (current_user.name rescue "Guest User"),
      :current_user_email => (current_user.email rescue "guestuser")
    }
  end


end