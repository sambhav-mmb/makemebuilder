class CreateUoms < ActiveRecord::Migration[5.1]
  def change
    create_table :uoms do |t|
      t.string :name
      t.integer :uom_type_id

      t.timestamps
    end
  end
end
