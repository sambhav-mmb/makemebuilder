class CreateAttributables < ActiveRecord::Migration[5.1]
  def change
    create_table :attributables do |t|
      t.integer :attribute_id
      t.references :attributable, polymorphic: true

      t.timestamps
    end
  end
end