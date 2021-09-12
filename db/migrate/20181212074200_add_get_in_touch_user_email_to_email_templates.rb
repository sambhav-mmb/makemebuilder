class AddGetInTouchUserEmailToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
  	add_column :email_templates, :get_in_touch_user_email, :text
  	add_column :email_templates, :get_in_touch_admin_email, :text
  end
end
