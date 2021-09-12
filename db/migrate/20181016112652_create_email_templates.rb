class CreateEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :email_templates do |t|
      t.text :custom_email
      t.text :contact_us_email
      t.text :vendor_approved_email
      t.text :vendor_reject_email
      t.text :news_letter_user_email
      t.text :news_letter_admin_email
      t.text :quote_user_email
      t.text :quote_admin_email

      t.timestamps
    end
  end
end
