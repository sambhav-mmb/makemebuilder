class CmsContent < ApplicationRecord

  include Statusable

  validates_presence_of :title
  validates_numericality_of :rank, greater_than_or_equal_to: 1

  # mount_uploader :icon, CmsContentIconUploader

  default_scope {order(:rank)}
  mount_uploader :icon, ImageUploader
  mount_uploader :image, ImageUploader

end