class AddMetaTagToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :meta_title, :string
    add_column :products, :meta_description, :text
  end
end
