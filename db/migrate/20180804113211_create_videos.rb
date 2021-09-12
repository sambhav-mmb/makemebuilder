class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :you_tube
      t.references :videoable, polymorphic: true

      t.timestamps
    end
  end
end