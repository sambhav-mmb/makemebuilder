class CreateAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_values do |t|
      t.integer :attribute_id
      t.string :value
      t.references :valueable, polymorphic: true

      t.timestamps
    end
  end
end