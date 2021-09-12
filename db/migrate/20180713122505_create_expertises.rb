class CreateExpertises < ActiveRecord::Migration[5.1]
  def change
    create_table :expertises do |t|
      t.integer :user_id
      t.string :name
      t.string :expertise_areas, array: true, default: []
      t.string :credentials
      t.text :desc
      t.string :tagline

      t.timestamps
    end
  end
end