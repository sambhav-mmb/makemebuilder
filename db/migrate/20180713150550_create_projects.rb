class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.string :developer
      t.string :location
      t.string :configuration
      t.date :completion_date
      t.integer :star_rating
      t.text :desc

      t.timestamps
    end
  end
end