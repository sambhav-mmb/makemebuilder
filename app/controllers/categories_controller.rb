class CategoriesController < ApplicationController

	def index
	end

	def products
		@category = Category.find(params[:category_id])
  
		if params[:sort] == "1"
			@products = @category.products.active.order("price asc")
		elsif params[:sort] == "2"
			@products = @category.products.active.order("price desc")
		elsif params[:sort] == "3"
			@products = @category.products.active.order("created_at desc")
		else
			@products = @category.products.active.paginate(:page => params[:page], :per_page => 6)
		end
		@featured_products = @category.main_category.products.active - @category.products.active
	end

	def get_main_categories
		service_category = ServiceCategory.find(params[:category_id])
		main_categories = service_category.main_categories
    render json: main_categories.map{|i| [i.id, i.name]}
	end

	def get_categories
		main_category = MainCategory.find(params[:category_id])
		categories = main_category.categories
    render json: categories.map{|i| [i.id, i.name]}
	end

	def quote
		@category = Category.find(params[:category_id])
		@custom_quote = CustomQuote.new
		@category.attributs.each do |attribut|
			@custom_quote.attribute_values.build(attribute_id: attribut.id)
		end
	end

	def custom_quote
		@category = Category.find(params[:custom_quote][:category_id])
		@custom_quote = CustomQuote.create(custom_quote_params_sep)
    logo_path = "#{request.host_with_port}/assets/logo.jpg"
		if @custom_quote.update(custom_quote_params)
    	QuoteMailer.user_email(@custom_quote.name, @custom_quote.email, logo_path).deliver_later
    	QuoteMailer.admin_email(@custom_quote, logo_path).deliver_later
    	flash[:notice] = "Thank you. Your request has been successfully received. Please check your email for confirmation. If you have any questions, contact us at tech@makemebuilder.com"
    	redirect_to "/categories/#{@category.id}/quote"
    else
    	render "quote"
    end
	end

	def custom_quote_params
    params.require(:custom_quote).permit(
      :category_id, :user_id, :first_name, :last_name, :email, :phone, :file, :comment, :details,
      :attribute_values_attributes => [:id, :attribute_id, :value, :valueable]
    )
  end

  def custom_quote_params_sep
    params.require(:custom_quote).permit(
      :category_id, :user_id, :first_name, :last_name, :email, :phone, :file, :comment, :details
    )
  end

end