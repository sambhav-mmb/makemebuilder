class AddInstituteToEducation < ActiveRecord::Migration[5.1]
  def change
    add_column :educations, :institute, :string
  end
end
