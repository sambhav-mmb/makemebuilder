class AddCertificationsToExpertise < ActiveRecord::Migration[5.1]
  def change
    add_column :expertises, :describe, :text, array: true, default: []
    add_column :expertises, :certifications, :text
    add_column :expertises, :certification_number, :text
  end
end
