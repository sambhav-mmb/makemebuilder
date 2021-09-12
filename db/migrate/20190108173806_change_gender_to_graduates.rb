class ChangeGenderToGraduates < ActiveRecord::Migration[5.1]
  def change
    rename_column :capacities, :gender, :graduates
  end
end
