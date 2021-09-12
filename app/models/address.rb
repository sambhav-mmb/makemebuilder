class Address < ApplicationRecord

	belongs_to :user

	validates :user_id, presence: true

	after_save :make_default

	default_scope {order(:created_at)}

  ADDRESS_TYPE = {1 => "Home", 2 => "Head Office", 3 => "Branch Office", 4 => "Manufacturing Office", 5 => "Distributor", 6 => "Back Office", 0 => "Other (specify)"}

	def make_default
		if self.user.addresses.where(is_default: true).count == 0
			self.update(is_default: true)
		end
	end

	def display_address_type
		address_type == 0 ? others : Address::ADDRESS_TYPE[address_type]
	end

end