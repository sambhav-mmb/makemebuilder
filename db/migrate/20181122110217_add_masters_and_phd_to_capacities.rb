class AddMastersAndPhdToCapacities < ActiveRecord::Migration[5.1]
  def change
    add_column :capacities, :masters_and_phd, :integer
  end
end
