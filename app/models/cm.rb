class Cm < ApplicationRecord

	has_many :cms_contents, dependent: :destroy
  accepts_nested_attributes_for :cms_contents, allow_destroy: true

  validates_presence_of :title

  mount_uploader :image, ImageUploader

end