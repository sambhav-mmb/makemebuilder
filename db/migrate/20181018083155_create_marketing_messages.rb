class CreateMarketingMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :marketing_messages do |t|
      t.string :title
      t.text :desc

      t.timestamps
    end
  end
end
