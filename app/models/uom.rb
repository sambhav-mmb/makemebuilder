class Uom < ApplicationRecord

	belongs_to :uom_type

	has_many :categories

	validates_presence_of :name

end