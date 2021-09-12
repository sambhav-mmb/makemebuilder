class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :name
      t.string :mobile
      t.text :address_line_1
      t.text :address_line_2
      t.string :country
      t.string :state
      t.string :city
      t.string :zip_code
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end