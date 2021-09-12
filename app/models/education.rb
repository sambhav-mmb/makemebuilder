class Education < ApplicationRecord

	belongs_to :user

  EDUCATION_TYPE = {1 => "10th", 2 => "12th", 3 => "Graduation", 4 => "Post Graduation", 5 => "Phd", 0 => "Other (specify)"}
  SPECIALIZATION = {1 => "Civil Engineering", 2 => "English Hons", 3 => "Digital Marketing", 0 => "Other (specify)"}

	def is_completed?
		 name.present? && year_of_graduation.present? && degree.present? && specialization.present?
	end

	def specialization_name
		specialization == 0 ? other_specialization : Education::SPECIALIZATION[specialization]
	end

	def qualification_name
		education == 0 ? other_education : Education::EDUCATION_TYPE[education]
	end

end
