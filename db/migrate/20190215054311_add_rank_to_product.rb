class AddRankToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :rank, :integer
  end
end
