class ChangeYearOfGraduationEducation < ActiveRecord::Migration[5.1]
  def change
  	remove_column :educations, :year_of_graduation
  	add_column :educations, :year_of_graduation, :integer
  end
end