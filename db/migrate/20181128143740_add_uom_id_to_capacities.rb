class AddUomIdToCapacities < ActiveRecord::Migration[5.1]
  def change
    add_column :capacities, :uom_id, :integer
  end
end
