class AddRankToJumboSlider < ActiveRecord::Migration[5.1]
  def change
    add_column :jumbo_sliders, :rank, :integer
  end
end