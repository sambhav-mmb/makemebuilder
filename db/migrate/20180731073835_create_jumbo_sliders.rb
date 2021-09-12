class CreateJumboSliders < ActiveRecord::Migration[5.1]
  def change
    create_table :jumbo_sliders do |t|
      t.string :name
      t.string :image
      t.string :url
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end