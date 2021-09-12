class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.text :call
      t.text :location

      t.timestamps
    end
  end
end
