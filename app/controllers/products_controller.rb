class ProductsController < ApplicationController

	def show
		@product = Product.find(params[:id])
		@category = @product.category
		if user_signed_in?
			current_user.recent_products.where(product_id: @product.id).destroy_all
			RecentProduct.create(user_id: current_user.id, session_id: session.id, product_id: @product.id)
		else
			RecentProduct.where(session_id: session.id, product_id: @product.id).destroy_all
			RecentProduct.create(session_id: session.id, product_id: @product.id)
		end
	end

	def search
		search = params[:q].downcase rescue nil
		categories = Category.active.where("lower(name) like '%#{search}%'")
		categories_products_ids = categories.map(&:products).flatten.map(&:id)
		products_ids = Product.active.where("lower(name) like '%#{search}%' OR lower(products.desc) like '%#{search}%'").map(&:id)
		unique_ids = (categories_products_ids + products_ids).uniq
		@products = Product.where(id: unique_ids).active.paginate(:page => params[:page], :per_page => 6)
		if params[:sort] == "1"
			@products = @products.order("price asc")
		elsif params[:sort] == "2"
			@products = @products.order("price desc")
		elsif params[:sort] == "3"
			@products = @products.order("created_at desc")
		end
	end

end