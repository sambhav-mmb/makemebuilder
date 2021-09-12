class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :desc
      t.string :image
      t.string :author
      t.integer :category_id
      t.boolean :is_featured
      t.boolean :is_service_category_featured
      t.integer :status_id, default: 1
      t.string :slug

      t.timestamps
    end
    add_index :blogs, :slug
  end
end