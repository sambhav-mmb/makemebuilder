class Expertise < ApplicationRecord

	belongs_to :user

  DESCRIBE = {1 => "DESIGNER/CONSULTANT", 2 => "MANPOWER PROVIDER", 3 => "TURNKEY CONRACTOR", 4 => "MATERIAL TRADER", 5 => "CUSTOM FABRICATOR", 6 => "MANUFACTURER"}

  before_save :sanitize_array_fields

  def sanitize_array_fields
    self.describe.reject!(&:empty?)
    self.expertise_areas.reject!(&:empty?)
  end

	def is_completed?
		name.present? && expertise_areas.present? && credentials.present? && desc.present?
	end

end