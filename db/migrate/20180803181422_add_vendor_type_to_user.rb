class AddVendorTypeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :vendor_type, :integer
  end
end