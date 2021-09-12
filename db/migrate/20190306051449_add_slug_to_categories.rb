class AddSlugToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :service_categories, :slug, :string
    add_column :main_categories, :slug, :string
    add_column :categories, :slug, :string

    add_index :service_categories, :slug
    add_index :main_categories, :slug
    add_index :categories, :slug
    add_index :products, :slug
  end
end
