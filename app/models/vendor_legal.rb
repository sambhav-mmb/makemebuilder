class VendorLegal < ApplicationRecord

	belongs_to :user

	validates_length_of :cin, is: 21
	validates_format_of :cin, with: /\A\w+\z/i, message: "can only contain letters and numbers."

	validates_format_of :gstn, with: /\A\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}\z/, message: "invalid."

	validates_format_of :pan, with: /\A[A-Za-z]{5}[0-9]{4}[A-z]{1}\z/, message: "invalid."

  COMPANY_TYPE = {1 => "One Person Company", 2 => "Private Limited", 3 => "Limited Company", 4 => "Section 8 Company", 5 => "Producer Company"}

	def is_completed?
		company_type_id.present? && incorporation_date.present? && gstn.present? && pan.present?
	end

end