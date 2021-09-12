class AddPaymentToCarts < ActiveRecord::Migration[5.1]
  def change
  	add_column :carts, :payment, :integer
  end
end
