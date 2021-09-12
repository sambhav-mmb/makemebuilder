class CreateEmployments < ActiveRecord::Migration[5.1]
  def change
    create_table :employments do |t|
      t.integer :user_id
      t.string :name
      t.string :role
      t.date :join_date
      t.date :end_date
      t.text :desc

      t.timestamps
    end
  end
end