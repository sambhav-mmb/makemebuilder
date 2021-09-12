class Team < ApplicationRecord

  include Statusable

  validates_presence_of :name, :designation
  validates_numericality_of :rank, greater_than_or_equal_to: 1

  mount_uploader :image, TeamImageUploader

  default_scope {order(:rank)}

end