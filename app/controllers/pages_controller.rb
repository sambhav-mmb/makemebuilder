class PagesController < ApplicationController

  before_action :authenticate_user!, only: :wishlist
  after_action :request_rejected
  after_action :request_approved

  def index
    # @cm_1 = Cm.find_by_id(1)
    # @cm_2 = Cm.find_by_id(2)
    # @cm_3 = Cm.find_by_id(3)
    # @cm_4 = Cm.find_by_id(4)
  end

  def about
    @cm_1 = Cm.find_by_id(1)
    @cm_4 = Cm.find_by_id(4)
  end

  def careers

    @cm = Cm.find_by_title("Careers")
    #@cm_38 = Cm.find_by_id(38)Catters
    @jobs = Job.all
    
  end 
  def career
    #@job = Job.all
    @job = Job.find_by(id: params[:id])

  end

  def how_we_work
    @cm_2 = Cm.find_by_id(2)
    @cm_3 = Cm.find_by_id(3)
  end

  def wishlist
    product_ids = current_user.wishlists.map(&:product_id)
    products = Product.where(id: product_ids)
    category_ids = current_user.wishlists.map{|m| m.product}.map(&:category_id)
    category = Category.where(id: category_ids)
    if params[:sort] == "1"
      return @products = products.sort_by{ |m| m.price }
    elsif params[:sort] == "2"
     return @products = products.sort_by{ |m| m.price }.reverse
    elsif params[:sort] == "3"
      return @products = products.sort_by{ |m| m.id }.reverse
    elsif params[:sort] == "4"
      return @products = category.sort_by{ |m| m.id}.reverse
    else
     return @products = products
    end
  end

  def quote
  	full_name = params[:full_name]
  	email = params[:email]
  	phone = params[:phone]
    category = params[:category]
    city = params[:city]
    locality = params[:locality]
  	requirement_details = params[:requirement_details]
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
    flash.now[:notice] = "Thank you. Your request has been successfully received. Please check your email for confirmation. If you have any questions, contact us at tech@makemebuilder.com"
    QuoteMailer.user_email(full_name, email, logo_path).deliver_later
    QuoteMailer.admin_email(full_name, email, phone, category, city, locality, requirement_details, logo_path).deliver_later
  end

  def news_letter
    email = params[:email]
    # logo_path = "#{request.host_with_port}/assets/logo.jpg"
    NewsLetter.subscribe(email)
    flash.now[:notice] = "Thank you for subscribing to our newsletter."
    # NewsLetterMailer.user_email(email, logo_path).deliver_later
    # NewsLetterMailer.admin_email(email, logo_path).deliver_later
  end

  def unsubscribe
    code = params[:code]
    NewsLetter.unsubscribe(code)
    flash[:notice] = "You've successfully unsubscribed to our newsletter."
    redirect_to root_path
  end

  def get_in_touch
    email = params[:email]
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
    flash.now[:notice] = "Thank you for get in touch."
    GetInTouchMailer.user_email(email, logo_path).deliver_later
    GetInTouchMailer.admin_email(email, logo_path).deliver_later
  end

  def contact_us_submit
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    website = params[:website]
    message = params[:message]
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
    flash.now[:notice] = "Thank you. Your request has been successfully received. We will be in touch with shortly."
    ContactUsMailer.admin_email(name, email, phone, website, message, logo_path).deliver_later
  end

  def get_states
    country = params[:country]
    country_code = CS.countries.to_a.select{|i| i[1] == country}[0][0]
    states = CS.states(country_code)
    if country == "India"
      states[:AN] = "Andaman and Nicobar Islands"
      states[:PY] = "Puducherry"
      states[:CT] = "Chhattisgarh"
      states[:HP] = "Himachal Pradesh"
      states[:JH] = "Jharkhand"
      states[:PB] = "Punjab"
      states[:DL] = "Delhi"
      states[:LD] = "Lakshadweep"
    end
    render json: states
  end

  def get_cities
    country = params[:country]
    state = params[:state]

    country_code = CS.countries.to_a.select{|i| i[1] == country}[0][0]
    states = CS.states(country_code)

    state_code = states.to_a.select{|i| i[1] == state}[0][0]
    cities = CS.cities(state_code, country_code)

    cities.delete_if{|i|i=="Delhi"}
    cities.delete_if{|i|i=="Haryana"}
    cities.delete_if{|i|i=="Goa"}

    render json: cities
  end

  def sitemap
    
  end


   def request_rejected
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    website = params[:website]
    message = params[:message]
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
    flash.now[:notice] = "Thank you. Your request has been successfully received. We will be in touch with shortly."
    # ConfirmationMailer.request_rejected(name, email, phone, website, message, logo_path).deliver_later
  end

  def request_approved
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    website = params[:website]
    message = params[:message]
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
    flash.now[:notice] = "Thank you. Your request has been successfully received. We will be in touch with shortly."
    # ConfirmationMailer.request_approved(name, email, phone, website, message, logo_path).deliver_later
  end
  
end