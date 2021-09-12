class JumboSlider < ApplicationRecord

	include Statusable

	belongs_to :product

	scope :active_till_date, -> {where("valid_till >= ?", Date.today)}

  mount_uploader :image, ImageUploader

  validates_numericality_of :rank, greater_than_or_equal_to: 1

end