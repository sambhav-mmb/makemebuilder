class AddRankToAttributable < ActiveRecord::Migration[5.1]
  def change
    add_column :attributables, :rank, :integer
  end
end
