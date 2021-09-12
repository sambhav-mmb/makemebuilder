class AddOtherTypeToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :other_type, :string
  end
end
