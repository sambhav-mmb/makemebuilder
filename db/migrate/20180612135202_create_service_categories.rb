class CreateServiceCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :service_categories do |t|
      t.string :short_name
      t.string :long_name
      t.string :tagline
      t.text :desc
      t.text :terms
      t.string :icon
      t.string :image
      t.integer :rank
      t.integer :status_id, default: 1

      t.timestamps
    end
  end
end