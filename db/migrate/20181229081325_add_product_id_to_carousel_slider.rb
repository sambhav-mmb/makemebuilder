class AddProductIdToCarouselSlider < ActiveRecord::Migration[5.1]
  def change
    add_column :carousel_sliders, :product_id, :integer
  end
end
