class CreateCustomQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_quotes do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :file
      t.text :comment
      t.text :details

      t.timestamps
    end
  end
end
