class AddVendorToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_vendor, :boolean, default: false
    add_column :users, :vendor_created_at, :datetime
    add_column :users, :is_approved, :boolean, default: false
    add_column :profiles, :website, :string
  end
end