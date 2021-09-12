class AddAddressToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :name, :string
    add_column :carts, :mobile, :string
    add_column :carts, :address_line_1, :text
    add_column :carts, :address_line_2, :text
    add_column :carts, :country, :string
    add_column :carts, :state, :string
    add_column :carts, :city, :string
    add_column :carts, :zip_code, :string
    add_column :carts, :is_address_saved, :boolean, default: false
  end
end