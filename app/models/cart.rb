class Cart < ApplicationRecord

	acts_as_shopping_cart_using :cart_item

  belongs_to :user

  has_one :order
  PAYMENT = [[1, "Cash on delivery"],[2, "card"],[3, "stripe"],[4, "paypal"]]


  # validates_presence_of :name, :mobile, :address_line_1, :address_line_2, :country, :state, :city, :zip_code

  def tax_pct
    0
  end

end