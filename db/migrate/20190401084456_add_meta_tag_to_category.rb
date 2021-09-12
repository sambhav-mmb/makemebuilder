class AddMetaTagToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :meta_title, :string
    add_column :categories, :meta_description, :text
  end
end
