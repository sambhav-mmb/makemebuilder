class CreateNewsLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :news_letters do |t|
      t.string :email, null: false, default: ""
      t.string :code, null: false, default: ""
      t.boolean :is_subscribed, default: true

      t.timestamps
    end
    add_index :news_letters, :email, unique: true
    add_index :news_letters, :code, unique: true
  end
end
