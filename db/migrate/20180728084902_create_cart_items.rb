class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.shopping_cart_item_fields # Creates the cart items fields
      
      # t.integer :owner_id
      # t.string :owner_type
      # t.integer :item_id
      # t.string :item_type
      # t.decimal :unit_price, precision: 12, scale: 3
      # t.integer :quantity, default: 1
      # t.decimal :total_price, precision: 12, scale: 3
      t.text :comment

      t.timestamps
    end
  end
end