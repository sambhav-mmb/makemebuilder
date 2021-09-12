class CartItem < ApplicationRecord

  acts_as_shopping_cart_item_for :cart

  before_save :item_currency

  # belongs_to :cart
  belongs_to :product

  # acts_as_shopping_cart_item_for :cart

  has_many :documents, :as => :docable, dependent: :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true

  validates :quantity, numericality: { greater_than: 0 }


  def product
  	Product.find_by_id(self.item_id)
  end

  def item_currency
    self.price_currency = "INR"
  end

  def total_price
    product.price * quantity
  end
  
  # def carto
  # 	Cart.find(self.owner_id)
  # end

  def display_price
    if self.price.to_f > 0
      "#{self.price}#{product.uom.present? ? '/'+product.uom.name.to_s : ''}"
    else
      "Upon Enquiry"
    end
  end

  def display_subtotal
    subtotal > 0 ? subtotal : "Upon Enquiry"
  end

  def list_name
    "#{quantity} #{product.uom.name rescue nil} of #{product.name}"
  end
  
end