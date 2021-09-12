class CartsController < ApplicationController

  before_action :authenticate_user!, except: :add_item

	def index
		
	end

	def add_item
		product = Product.find(params[:cart_item][:product_id])
		unless user_signed_in?
			store_location_for(:user, request.referer)
			flash[:notice] = "You need to sign in or sign up before continuing."
			redirect_to "/users/sign_in"
		else
			cart_item = current_cart.add(product, product.price, params[:cart_item][:quantity].to_i)
			cart_item.update(comment: params[:cart_item][:comment])
			flash[:notice] = "The product has been added to your Cart."
			redirect_to "/carts"
		end
	end

	def update_item
		# cart_item = CartItem.find(params[:cart_item][:cart_item_id])
		@cart_item = CartItem.find(params[:cart_id])

		# cart_item.update(quantity: params[:cart_item][:quantity],comment: params[:cart_item][:comment])
		@cart_item.update(cart_item_params)
		# flash[:notice] = "The item has been updated in your Cart."
		# redirect_to "/carts"
	end

	def update_item_comment
		@cart_item = CartItem.find(params[:cart_id])
		@cart_item.update(cart_item_params)
		render body: nil
	end

	# def update_item_doc
	# 	@cart_item = CartItem.find(params[:cart_id])
	# 	@cart_item.update(cart_item_params)
	# 	# flash[:notice] = "The item has been updated in your Cart."
	# end

	def delete_item_doc
		@cart_item = CartItem.find(params[:cart_id])
		document = @cart_item.documents.find(params[:doc])
		if document.present?
			document.destroy
		end
		# flash[:notice] = "Document has been deleted from your Cart."
		# redirect_to "/carts"
		# @cart_item = CartItem.find(params[:cart_id])
		# @cart_item.update(cart_item_params)
		# flash[:notice] = "The item has been updated in your Cart."
	end

	def remove_item
		cart_item = CartItem.find(params[:cart_id])
		cart_item.destroy
		flash[:notice] = "The item has been removed from your Cart."
		redirect_to "/carts"
	end

	def review
		unless current_cart.is_address_saved
			default_address = current_user.default_address
			if default_address.present?
				current_cart.update(
					name: default_address.name,
					mobile: default_address.mobile,
					email: current_user.email,
					address_line_1: default_address.address_line_1,
					address_line_2: default_address.address_line_2,
					country: default_address.country,
					state: default_address.state,
					city: default_address.city,
					zip_code: default_address.zip_code,

					billing_name: default_address.name,
					billing_mobile: default_address.mobile,
					billing_email: current_user.email,
					billing_address_line_1: default_address.address_line_1,
					billing_address_line_2: default_address.address_line_2,
					billing_country: default_address.country,
					billing_state: default_address.state,
					billing_city: default_address.city,
					billing_zip_code: default_address.zip_code,

					is_address_saved: true
				)
			end
		end
	end
	def payment
		 cart_item = current_user.addresses.where(id: params[:cart_id])
		unless current_cart.is_address_saved
			default_address = current_user.default_address
		end
	end

	def set_address
		address = current_user.addresses.where(id: params[:cart_id]).first
		if address.present?
			current_cart.update(
				name: address.name,
				mobile: address.mobile,
				address_line_1: address.address_line_1,
				address_line_2: address.address_line_2,
				country: address.country,
				state: address.state,
				city: address.city,
				zip_code: address.zip_code,
				payment: payment,
				is_address_saved: true
			)
		end
		redirect_to cart_review_path(current_cart)
	end

	def new_address
		@cart = Cart.new

    @countries = CS.countries.map{|c| [c.last, c.last]}

    country_code = CS.countries.to_a.select{|i| i[1] == "India"}[0][0]

    @states_hash = CS.states(country_code)
    @states_hash[:AN] = "Andaman and Nicobar Islands"
    @states_hash[:PY] = "Puducherry"
    @states_hash[:CT] = "Chhattisgarh"
    @states_hash[:HP] = "Himachal Pradesh"
    @states_hash[:JH] = "Jharkhand"
    @states_hash[:PB] = "Punjab"
    @states_hash[:DL] = "Delhi"
    @states_hash[:LD] = "Lakshadweep"
    @states = CS.states(country_code).map{|c| [c.last, c.last]}

    
    @cities = {}

		render "address"
	end

	def edit_address
		@cart = current_cart

		@countries = CS.countries.map{|c| [c.last, c.last]}
    country = @cart.country
    country_code = CS.countries.to_a.select{|i| i[1] == country}[0][0]
    @states_hash = CS.states(country_code)
    if country = "India"
      @states_hash[:AN] = "Andaman and Nicobar Islands"
      @states_hash[:PY] = "Puducherry"
      @states_hash[:CT] = "Chhattisgarh"
      @states_hash[:HP] = "Himachal Pradesh"
      @states_hash[:JH] = "Jharkhand"
      @states_hash[:PB] = "Punjab"
      @states_hash[:DL] = "Delhi"
      @states_hash[:LD] = "Lakshadweep"
    end
    @states = CS.states(country_code).map{|c| [c.last, c.last]}
    state = @cart.state
    state_code = @states_hash.to_a.select{|i| i[1] == state}[0][0] rescue nil
    @cities = CS.cities(state_code, country_code)
    @cities.delete_if{|i|i=="Delhi"}
    @cities.delete_if{|i|i=="Haryana"}
    @cities.delete_if{|i|i=="Goa"}
		render "address"
	end

	def update_address
		current_cart.update(cart_params)
		current_cart.update(is_address_saved: true)
		if params[:cart][:checkout_address_type] == "new_address"
			address = current_user.addresses.build(cart_params)
			address.save
		end
		redirect_to cart_review_path(current_cart)
	end

	def set_billing_address
		address = current_user.addresses.where(id: params[:cart_id]).first
		if address.present?
			current_cart.update(
				billing_name: address.name,
				billing_mobile: address.mobile,
				billing_address_line_1: address.address_line_1,
				billing_address_line_2: address.address_line_2,
				billing_country: address.country,
				billing_state: address.state,
				billing_city: address.city,
				billing_zip_code: address.zip_code,
				is_address_saved: true
			)
		end
		redirect_to cart_review_path(current_cart)
	end

	def new_billing_address
		@cart = Cart.new

    @countries = CS.countries.map{|c| [c.last, c.last]}
    @states = {}
    @cities = {}

		render "billing_address"
	end

	def edit_billing_address
		@cart = current_cart

		@countries = CS.countries.map{|c| [c.last, c.last]}
    country = @cart.billing_country
    country_code = CS.countries.to_a.select{|i| i[1] == country}[0][0]
    @states_hash = CS.states(country_code)
    @states = CS.states(country_code).map{|c| [c.last, c.last]}
    state = @cart.billing_state
    state_code = @states_hash.to_a.select{|i| i[1] == state}[0][0]
    @cities = CS.cities(state_code, country_code)

		render "billing_address"
	end

	def update_billing_address
		current_cart.update(cart_params)
		current_cart.update(is_address_saved: true)
		redirect_to cart_review_path(current_cart)
	end

	private

    def cart_params
      params.require(:cart).permit(:name, :mobile, :email, :address_line_1, :address_line_2, :landmark, :country, :state, :city, :zip_code, :billing_name, :billing_mobile, :billing_address_line_1, :billing_address_line_2, :billing_country, :billing_state, :billing_city, :billing_zip_code, :payment)
    end

    def cart_item_params
      params.require(:cart_item).permit(:quantity, :comment,
        :documents_attributes => [:id, :doc, :docable]
      )
    end
	
end