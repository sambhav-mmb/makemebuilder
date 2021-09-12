class CreateVendorLegals < ActiveRecord::Migration[5.1]
  def change
    create_table :vendor_legals do |t|
      t.integer :user_id
      t.string :company_type
      t.date :incorporation_date
      t.string :gstn
      t.string :pan

      t.timestamps
    end
  end
end