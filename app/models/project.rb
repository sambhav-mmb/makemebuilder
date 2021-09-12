class Project < ApplicationRecord

	belongs_to :user

  PROJECT_TYPE = {1 => "Group Housing", 2 => "Independent Houses", 3 => "Retail", 4 => "Office", 5 => "Hotel", 6 => "Entertainment", 7 => "Healthcare", 8 => "Industrial", 9 => "Transportation", 10 => "Infrastructure", 0 => "Other (specify)"}

	def is_completed?
		name.present? && type.present? && developer.present? && location.present? && configuration.present? && desc.present?
	end

	self.inheritance_column = :_type_disabled

end