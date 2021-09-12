class CarouselSlider < ApplicationRecord

	include Statusable

	belongs_to :product

  mount_uploader :image, CarouselSliderUploader

  validates_numericality_of :rank, greater_than_or_equal_to: 1

end