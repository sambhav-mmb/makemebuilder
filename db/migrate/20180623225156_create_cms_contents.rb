class CreateCmsContents < ActiveRecord::Migration[5.1]
  def change
    create_table :cms_contents do |t|
      t.integer :cm_id
      t.string :title
      t.text :desc
      t.string :icon
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end