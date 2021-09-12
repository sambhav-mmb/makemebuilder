class AddLandmarkToCart < ActiveRecord::Migration[5.1]
  def change
    add_column :carts, :landmark, :string
    add_column :addresses, :landmark, :string
  end
end
