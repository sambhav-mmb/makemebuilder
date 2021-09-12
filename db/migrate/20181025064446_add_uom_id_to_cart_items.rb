class AddUomIdToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_column :cart_items, :uom_id, :integer
  end
end
