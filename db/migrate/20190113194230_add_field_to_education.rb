class AddFieldToEducation < ActiveRecord::Migration[5.1]
  def change
    add_column :educations, :education, :integer
    add_column :educations, :other_education, :string
    add_column :educations, :board, :text
    remove_column :educations, :specialization
  	add_column :educations, :specialization, :integer
    add_column :educations, :other_specialization, :string
  end
end
