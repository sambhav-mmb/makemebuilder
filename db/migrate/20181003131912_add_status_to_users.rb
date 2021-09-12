class AddStatusToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :vendor_status, :integer, default: 1
    add_column :users, :date, :date
  end
end
