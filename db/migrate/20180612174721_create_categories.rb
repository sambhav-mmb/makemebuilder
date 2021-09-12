class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :main_category_id
      t.string :name
      t.string :tagline
      t.text :desc
      t.text :terms
      t.string :icon
      t.string :image
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end