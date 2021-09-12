class Product < ApplicationRecord

	include Statusable

	extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  self.primary_key = "id"
  # TYPE = {1 => "MMB Supplied", 2 => "Custom"}

	belongs_to :category
  # belongs_to :uom, optional: true

	validates_presence_of :name, :category_id

  validates_numericality_of :rank, greater_than_or_equal_to: 1

	has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :attributs, through: :category

  has_many :cart_items, as: :item, dependent: :destroy
  has_many :recent_products, dependent: :destroy

  # has_many :attributables, as: :attributable, dependent: :destroy
  # has_many :attributables, through: :category

  # has_many :attributs, through: :attributables
  # accepts_nested_attributes_for :attributables, allow_destroy: true

  delegate :main_category, to: :category, allow_nil: true
  delegate :service_category, to: :main_category, allow_nil: true

  delegate :uom, to: :category, allow_nil: true

  has_many :attribute_values, as: :valueable, dependent: :destroy
  accepts_nested_attributes_for :attribute_values

  mount_uploader :image, ProductImageUploader
  mount_uploader :image1, ProductImageUploader
  mount_uploader :image2, ProductImageUploader
  mount_uploader :image3, ProductImageUploader
  mount_uploader :image4, ProductImageUploader
  has_many :uoms, as: :uomable#, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  accepts_nested_attributes_for :uoms, allow_destroy: true

  after_save :update_cart

  def display_price
    result = ""
    if self.price.to_f > 0
      result += "#{self.price.to_i}"
      result += "/#{self.uom.name}" if self.uom.present?
      # "/#{self.uom_id.present? ? Uom.find(self.uom_id).try(:name) : ''}"
    else
      result += "Upon Enquiry"
    end
    return result
  end

  def display_full_price
    result = ""
    if self.full_price.to_f > 0
      result += "#{self.full_price.to_i}"
      result += "/#{self.uom.name}" if self.uom.present?
      # "/#{self.uom_id.present? ? Uom.find(self.uom_id).try(:name) : ''}"
    else
      result += "Upon Enquiry"
    end
    return result
  end

  def category_desc
    result = ""
    result += "<a href='/categories?scrollto=service-category-#{service_category.id}&service_category=#{service_category.id}'>#{service_category.short_name}</a> >> " if service_category.present?
    result += "<a href='/categories?scrollto=main-category-#{main_category.id}&service_category=#{service_category.id}'>#{main_category.short_name}</a> >> " if main_category.present?
    result += "<a href='#{category.url}'>#{category.name}</a>" if category.present?
  end

  def discount_percentage
    if price.present? && price > 0 && full_price.present? && full_price > 0
      " " + (100 - (price.to_f / full_price.to_f * 100.0)).to_s + "%"
      # "Discount: " + (100 - (price.to_f / full_price.to_f * 100.0)).to_s + "%"
    else
      nil
    end
  end

  def update_cart
    if price_changed?
      cart_item_ids = Cart.where(is_ordered: false).collect(&:cart_items).flatten.map(&:id)
      cart_items = CartItem.where(id: cart_item_ids, item_id: self.id, item_type: "Product")
      cart_items.each do |cart_item|
        cart_item.update(price: self.price)
      end
    end
  end

  def share_title
    "#{service_category.name} >> #{main_category.name} >> #{category.name} >> #{name}"
  end

  def type_name
    category.type_name
  end

  def parent_terms
    "#{service_category.try(:terms)} #{main_category.try(:terms)} #{category.try(:terms)}"
  end

  def all_terms
    "#{service_category.try(:terms)} #{main_category.try(:terms)} #{category.try(:terms)} #{terms_and_conditions}"
  end

  def url
    "/products/#{self.service_category.slug}/#{self.main_category.slug}/#{self.category.slug}/#{self.slug}"
  end

  ransacker :uom, formatter: proc {|value|
    results = Uom.find(value).categories.map(&:products).flatten.compact.map(&:id) # return only id-s of returned items.
    results.present? ? results : nil
  } do |parent|
    parent.table[:id]
  end

end