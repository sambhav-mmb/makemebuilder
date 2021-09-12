class Blog < ApplicationRecord

	include Statusable

	extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  self.primary_key = "id"
	
  belongs_to :category, optional: true

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :videos, as: :videoable, dependent: :destroy
  accepts_nested_attributes_for :videos, allow_destroy: true

  delegate :main_category, to: :category, allow_nil: true
  delegate :service_category, to: :main_category, allow_nil: true

  validates_presence_of :title, :category_id

  scope :service_category_featured, -> {where(is_service_category_featured: true)}

  mount_uploader :image, BlogImageUploader

  after_save :update_featured
  after_save :update_service_category_featured

  def update_featured
  	if self.is_featured == true
  		Blog.where.not(id: self.id).where(is_featured: true).update_all(is_featured: false)
  	end
  end

  def update_service_category_featured
  	if self.category.nil?
  		Blog.where(id: self.id).update_all(is_service_category_featured: false)
  	elsif self.is_service_category_featured == true
  		Blog.where.not(id: self.id).where(category_id: self.service_category.categories.map(&:id), is_service_category_featured: true).update_all(is_service_category_featured: false)
	  end
  end

  def self.featured
    where(is_featured: true).first
  end

end