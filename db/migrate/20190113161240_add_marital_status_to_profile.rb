class AddMaritalStatusToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :marital_status, :integer
  end
end
