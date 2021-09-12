class AddMetaKeywords < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :meta_keywords, :text
    add_column :blogs, :meta_keywords, :text
    add_column :products, :meta_keywords, :text
    add_column :settings, :meta_keywords, :text
  end
end
