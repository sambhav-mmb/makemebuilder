class AddProductToJumboSlider < ActiveRecord::Migration[5.1]
  def change
    add_column :jumbo_sliders, :product_id, :integer
    add_column :jumbo_sliders, :valid_till, :date
  end
end
