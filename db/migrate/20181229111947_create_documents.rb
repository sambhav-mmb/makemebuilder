class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :doc
      t.references :docable, polymorphic: true

      t.timestamps
    end
  end
end
