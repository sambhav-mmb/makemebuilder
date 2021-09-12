class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.string :ip_address
      t.string :name
      t.string :mobile
      t.text :billing_address_1
      t.text :billing_address_2
      t.string :country
      t.string :state
      t.string :city
      t.string :zip_code
      t.integer :status, default: 1

      t.timestamps
    end
  end
end