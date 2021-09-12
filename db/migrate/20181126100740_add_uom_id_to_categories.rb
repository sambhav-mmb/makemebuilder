class AddUomIdToCategories < ActiveRecord::Migration[5.1]
  def change
  	add_column :categories, :uom_id, :integer
  end
end
