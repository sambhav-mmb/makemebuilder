class AddFullPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :full_price, :float
  end
end
