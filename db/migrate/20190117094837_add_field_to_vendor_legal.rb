class AddFieldToVendorLegal < ActiveRecord::Migration[5.1]
  def change
    remove_column :vendor_legals, :company_type
  	add_column :vendor_legals, :company_type_id, :integer
  	add_column :vendor_legals, :cin, :string
  end
end
