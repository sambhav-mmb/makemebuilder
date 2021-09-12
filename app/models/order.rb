class Order < ApplicationRecord

	belongs_to :cart

	STATUS = {1=> "Enquiry Generated", 2=> "Contacted", 3=> "Quoted", 4=> "Completed", 5=> "Cancelled"}

end
