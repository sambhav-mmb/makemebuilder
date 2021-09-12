class AddLinkedinToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :linkedin, :string
  	add_column :users, :facebook, :string
  	add_column :users, :twitter, :string
  	add_column :users, :google, :string
  	add_column :users, :pintrest, :string
  	add_column :users, :instagram, :string
  end
end
