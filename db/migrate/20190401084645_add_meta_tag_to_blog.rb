class AddMetaTagToBlog < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :meta_title, :string
    add_column :blogs, :meta_description, :text
  end
end
