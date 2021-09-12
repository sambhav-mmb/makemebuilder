class CreateBusinessProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :business_profiles do |t|
      t.integer :user_id
      t.string :company_name
      t.string :owner_ceo_name
      t.string :owner_ceo_mobile
      t.string :landline
      t.string :logo
      t.string :linkedin
      t.string :facebook
      t.string :twitter
      t.string :google
      t.string :pintrest
      t.string :instagram

      t.timestamps
    end
  end
end
