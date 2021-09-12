class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :code
      t.string :name
      t.string :color, default: "000"
      t.string :bgcolor, default: "FFF"
      t.integer :rank
      t.string :notes

      t.timestamps
    end
  end
end