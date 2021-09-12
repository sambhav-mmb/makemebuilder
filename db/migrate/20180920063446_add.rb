class Add < ActiveRecord::Migration[5.1]
  def change
  	add_column :cms_contents, :image, :string
  end
end
