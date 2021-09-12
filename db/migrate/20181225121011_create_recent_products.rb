class CreateRecentProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :recent_products do |t|
      t.integer :user_id
      t.string :session_id
      t.integer :product_id

      t.timestamps
    end
  end
end