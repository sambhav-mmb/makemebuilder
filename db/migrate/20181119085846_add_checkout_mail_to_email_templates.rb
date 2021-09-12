class AddCheckoutMailToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
  	add_column  :email_templates, :checkout_mail, :string
  end
end
