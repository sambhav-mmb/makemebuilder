class ChangeDefaultInProject < ActiveRecord::Migration[5.1]
  def change
  	remove_column :projects, :country
  	remove_column :projects, :state
  	remove_column :projects, :city
  	add_column :projects, :country, :string, default: "India"
    add_column :projects, :state, :string, default: "Delhi"
    add_column :projects, :city, :string, default: "New Delhi"
  end
end
