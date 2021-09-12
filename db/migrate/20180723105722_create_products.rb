class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :desc
      t.string :image
      t.float :price
      t.integer :category_id
      t.integer :status_id, default: 2
      t.string :slug

      t.timestamps
    end
  end
end