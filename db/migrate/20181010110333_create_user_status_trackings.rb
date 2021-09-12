class CreateUserStatusTrackings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_status_trackings do |t|
      t.integer :vendor_status
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
