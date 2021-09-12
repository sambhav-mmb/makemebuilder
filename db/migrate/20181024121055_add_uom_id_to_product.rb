class AddUomIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :uom_id, :integer
  end
end
