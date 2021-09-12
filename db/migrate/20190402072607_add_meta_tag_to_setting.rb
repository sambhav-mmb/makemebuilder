class AddMetaTagToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :meta_title, :string
    add_column :settings, :meta_description, :text
  end
end