class AddBillingAddressToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :billing_name, :string
    add_column :carts, :billing_mobile, :string
    add_column :carts, :billing_address_line_1, :text
    add_column :carts, :billing_address_line_2, :text
    add_column :carts, :billing_country, :string
    add_column :carts, :billing_state, :string
    add_column :carts, :billing_city, :string
    add_column :carts, :billing_zip_code, :string
  end
end