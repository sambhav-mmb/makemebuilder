class CreateCapacities < ActiveRecord::Migration[5.1]
  def change
    create_table :capacities do |t|
      t.integer :user_id
      t.integer :gender
      t.integer :diploma_holders
      t.integer :skilled_workers
      t.integer :turnover
      t.string :volume
      t.integer :year

      t.timestamps
    end
  end
end