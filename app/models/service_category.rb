class ServiceCategory < ApplicationRecord

  include Statusable

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.primary_key = "id"
  
  has_many :main_categories, dependent: :destroy
  has_many :categories, through: :main_categories
  has_many :products, through: :categories
  has_many :blogs, through: :categories
  has_many :attributs, through: :categories

  validates_presence_of :short_name, :long_name
  validates_numericality_of :rank, allow_nil: true, greater_than_or_equal_to: 1

  mount_uploader :icon, CategoryIconUploader
  mount_uploader :image, ImageUploader

  default_scope {order(:rank)}

  def name
  	short_name
  end

  def self.form_select_main_categories
    result = ""
    ServiceCategory.all.each do |service_category|
      result += "<optgroup label='#{service_category.name}'>"
      service_category.main_categories.each do |main_category|
        result += "<option value='#{main_category.id}'>#{main_category.name}</option>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end

  def self.form_select_categories(blog = blog)
  	result = ""
  	ServiceCategory.all.each do |service_category|
  		result += "<optgroup label='#{service_category.name}'>"
  		service_category.main_categories.each do |main_category|
	  		result += "<optgroup label='&nbsp;&nbsp;#{main_category.name}'>"
	  		main_category.categories.each do |category|
          if blog.present?
		  		  result += "<option value='#{category.id}' #{blog.category_id == category.id ? 'selected=selected' : ''}>#{category.name}</option>"
          else
            result += "<option value='#{category.id}'>#{category.name}</option>"
          end
		  	end
		  	result += "</optgroup>"
	  	end
  		result += "</optgroup>"
  	end
    result.html_safe
  end

  def self.form_select_categories_education(education)
    result = ""
    ServiceCategory.all.each do |service_category|
      result += "<optgroup label='#{service_category.name}'>"
      service_category.main_categories.each do |main_category|
        result += "<optgroup label='&nbsp;&nbsp;#{main_category.name}'>"
        main_category.categories.each do |category|
          result += "<option value='#{category.id}' #{education.specialization == category.id ? 'selected=selected' : ''}>#{category.name}</option>"
        end
        result += "</optgroup>"
      end
      result += "</optgroup>"
    end
    result += "<option value='0' #{education.specialization == 0 ? 'selected=selected' : ''}>Other (specify)</option>"
    result.html_safe
  end

  def self.form_select_categories_expertise_areas(expertise)
    result = ""
    ServiceCategory.all.each do |service_category|
      result += "<optgroup label='#{service_category.name}'>"
      service_category.main_categories.each do |main_category|
        result += "<optgroup label='&nbsp;&nbsp;#{main_category.name}'>"
        main_category.categories.each do |category|
          result += "<option value='#{category.id}'>#{category.category_desc}</option>"
        end
        result += "</optgroup>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end

  def self.form_select_products(carousel_slider)
    result = ""
    ServiceCategory.all.each do |service_category|
      result += "<optgroup label='#{service_category.name}'>"
      service_category.main_categories.each do |main_category|
        result += "<optgroup label='&nbsp;&nbsp;#{main_category.name}'>"
        main_category.categories.each do |category|
          result += "<optgroup label='&nbsp;&nbsp;&nbsp;&nbsp;#{category.name}'>"
          category.products.each do |product|
            result += "<option value='#{product.id}' #{carousel_slider.product_id == product.id ? 'selected=selected' : ''}>#{"&nbsp;&nbsp;" + product.name}</option>"
          end
          result += "</optgroup>"
        end
        result += "</optgroup>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end

  def self.form_select_blogs(carousel_slider)
    result = ""
    ServiceCategory.joins(:blogs).uniq.each do |service_category|
      result += "<optgroup label='#{service_category.name}'>"
      service_category.main_categories.joins(:blogs).uniq.each do |main_category|
        result += "<optgroup label='&nbsp;&nbsp;#{main_category.name}'>"
        main_category.categories.joins(:blogs).uniq.each do |category|
          result += "<optgroup label='&nbsp;&nbsp;&nbsp;&nbsp;#{category.name}'>"
          category.blogs.each do |blog|
            result += "<option value='#{blog.id}' #{carousel_slider.blog == blog.id ? 'selected=selected' : ''}>#{"&nbsp;&nbsp;" + blog.title}</option>"
          end
          result += "</optgroup>"
        end
        result += "</optgroup>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end
  
end