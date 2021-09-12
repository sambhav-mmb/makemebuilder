class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :designation
      t.text :desc
      t.string :linkedin_url
      t.string :image
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end