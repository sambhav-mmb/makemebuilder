class CreateEducations < ActiveRecord::Migration[5.1]
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :name
      t.date :year_of_graduation
      t.string :degree
      t.string :specialization

      t.timestamps
    end
  end
end