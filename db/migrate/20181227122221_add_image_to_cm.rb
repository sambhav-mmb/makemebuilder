class AddImageToCm < ActiveRecord::Migration[5.1]
  def change
    add_column :cms, :image, :string
  end
end
