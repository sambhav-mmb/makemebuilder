class AddCompanyToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :company_name, :string
    add_column :projects, :contact_person, :string
    add_column :projects, :contact_person_mobile, :string
    add_column :projects, :country, :string
    add_column :projects, :state, :string
    add_column :projects, :city, :string
    add_column :projects, :builtup_area, :string
    add_column :projects, :capacity, :string
  end
end