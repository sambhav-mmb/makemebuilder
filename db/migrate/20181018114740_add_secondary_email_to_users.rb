class AddSecondaryEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :secondary_email, :string, null: false, default: ""
  end
end
