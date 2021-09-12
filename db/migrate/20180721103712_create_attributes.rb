class CreateAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :attributes do |t|
      t.string :name
      t.integer :display_type
      t.string :values, array: true, default: []

      t.timestamps
    end
  end
end