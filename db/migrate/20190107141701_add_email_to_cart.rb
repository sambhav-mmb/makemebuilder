class AddEmailToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :email, :string
    add_column :carts, :billing_email, :string
  end
end
