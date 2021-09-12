class Employment < ApplicationRecord

	belongs_to :user

	def is_completed?
		 name.present? && role.present? && join_date.present? && end_date.present? && desc.present?
	end

end
