class AddTermsAndConditionsToProducts < ActiveRecord::Migration[5.1]
  def change
	add_column :products, :terms_and_conditions, :text
  end
end
