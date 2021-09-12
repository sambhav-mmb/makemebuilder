class AddTurnoverCurrencyToCapacity < ActiveRecord::Migration[5.1]
  def change
    add_column :capacities, :turnover_currency, :integer, default: 1
  end
end