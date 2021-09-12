class CreateCarousels < ActiveRecord::Migration[5.1]
  def change
    create_table :carousels do |t|
      t.string :name
      t.integer :blog_id
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end