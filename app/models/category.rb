class Category < ApplicationRecord

	include Statusable

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.inheritance_column = :_type_disabled
  self.per_page = 3

  TYPE = [[1, "Direct Connect"],[2, "MMB Assigned"],[3, "Bidding"],[4, "Lead Selling"]]
  TYPE_REVERSE = [["Direct Connect", 1],["MMB Assigned", 2],["Bidding", 3],["Lead Selling", 4]]


  belongs_to :main_category
  delegate :service_category, to: :main_category

  belongs_to :uom, optional: true

  has_many :blogs, dependent: :destroy
  has_many :products, dependent: :destroy

  has_many :attributables, as: :attributable, dependent: :destroy
  has_many :attributs, through: :attributables
  accepts_nested_attributes_for :attributables, allow_destroy: true

  validates_presence_of :main_category_id, :name#, :type
  validates_numericality_of :rank, allow_nil: true, greater_than_or_equal_to: 1

  mount_uploader :icon, CategoryIconUploader
  mount_uploader :image, ImageUploader

  default_scope {order(:rank)}

  def is_standard?
    self.type == 1 || self.type == 2
  end

  def is_custom?
    self.type == 3 || self.type == 4
  end

  def type_name
    Category::TYPE.to_h[self.type]
  end

  def url
    if self.is_standard?
      # "/categories/#{self.id}/products"
      "/categories/#{self.service_category.slug}/#{self.main_category.slug}/#{self.slug}/products"
    elsif self.is_custom?
      "/categories/#{self.service_category.slug}/#{self.main_category.slug}/#{self.slug}/quote"
      # "/categories/#{self.id}/quote"
    else
      "#"
    end
  end

  def category_desc
    result = ""
    result += "<a href='/categories?scrollto=service-category-#{service_category.id}&service_category=#{service_category.id}'>#{service_category.short_name}</a> >> " if service_category.present?
    result += "<a href='/categories?scrollto=main-category-#{main_category.id}&service_category=#{service_category.id}'>#{main_category.short_name}</a> >> " if main_category.present?
    result += "#{self.name}"
  end

  def uom_name
    "#{uom.name} of #{name}"
  end

  ransacker :service_category, formatter: proc {|value|
    results = ServiceCategory.find(value).categories.pluck(:id) # return only id-s of returned items.
    results.present? ? results : nil
  } do |parent|
    parent.table[:id]
  end

end