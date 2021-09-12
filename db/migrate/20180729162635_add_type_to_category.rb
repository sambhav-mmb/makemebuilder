class AddTypeToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :type, :integer
  end
end