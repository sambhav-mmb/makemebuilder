class MainCategory < ApplicationRecord

  include Statusable

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.primary_key = "id"
  
  belongs_to :service_category

  has_many :categories, dependent: :destroy
  has_many :products, through: :categories
  has_many :blogs, through: :categories
  has_many :attributs, through: :categories

  validates_presence_of :service_category_id, :short_name
  validates_numericality_of :rank, allow_nil: true, greater_than_or_equal_to: 1

  mount_uploader :icon, CategoryIconUploader
  mount_uploader :image, ImageUploader

  default_scope {order(:rank)}

  def name
  	short_name
  end

end