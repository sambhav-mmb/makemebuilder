class AddConfirmationToEmailTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :email_templates, :confirmation, :string
    add_column :email_templates, :under_review_admin, :string
    add_column :email_templates, :under_review_user, :string
  end
end
