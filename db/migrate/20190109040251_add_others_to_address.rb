class AddOthersToAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :others, :string
  end
end
