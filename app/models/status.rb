class Status < ApplicationRecord

  default_scope {order(:rank)}

  validates_numericality_of :rank, greater_than_or_equal_to: 1

end