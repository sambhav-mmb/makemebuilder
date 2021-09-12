class AddAttributeTypeToAttribute < ActiveRecord::Migration[5.1]
  def change
    add_column :attributes, :attribute_type_id, :integer
  end
end