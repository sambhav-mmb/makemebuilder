class BlogsController < ApplicationController

	def index
		@featured_blog = Blog.featured
		# @blogs = Blog.service_category_featured
		@blogs = Blog.active
	end

	def service_category
		@featured_blog = Blog.featured
		@service_category = ServiceCategory.find(params[:service_category_id])
		@categories = @service_category.categories
		@blogs = Blog.where(category_id: @categories.map(&:id))
		render "index"
	end

	def main_category
		@featured_blog = Blog.featured
		@main_category = MainCategory.find(params[:main_category_id])
		@categories = @main_category.categories
		@blogs = Blog.where(category_id: @categories.map(&:id))
		render "index"
	end

	def category
		@featured_blog = Blog.featured
		@blogs = Blog.where(category_id: params[:category_id])
		render "index"
	end

	def show
		@blog = Blog.find(params[:id])
	end
	
end