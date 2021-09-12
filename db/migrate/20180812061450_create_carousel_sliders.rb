class CreateCarouselSliders < ActiveRecord::Migration[5.1]
  def change
    create_table :carousel_sliders do |t|
      t.integer :carousel_id
      t.string :name
      t.text :desc
      t.string :image
      t.string :link_name
      t.string :link_url
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end