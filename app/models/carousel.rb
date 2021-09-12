class Carousel < ApplicationRecord

	include Statusable

	belongs_to :blog, optional: true

	self.primary_key = "id"

  has_many :carousel_sliders, dependent: :destroy
  accepts_nested_attributes_for :carousel_sliders, allow_destroy: true

  validates_numericality_of :rank, greater_than_or_equal_to: 1

end