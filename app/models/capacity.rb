class Capacity < ApplicationRecord

  belongs_to :user

	def is_completed?
		graduates.present? && diploma_holders.present? && skilled_workers.present? && turnover.present? && volume.present? && year.present?
	end

	MASTERS_AND_PHDS = [[1, "1-10"],[2, "10-100"],[3, "100-1000"],[4, ">1000"]]
  GRADUATES = [[1, "1-10"],[2, "10-100"],[3, "100-1000"],[4, ">1000"]]
  DIPLOMA_HOLDERS = [[1, "1-10"],[2, "10-100"],[3, "100-1000"],[4, ">1000"]]
  SKILLED_WORKERS = [[1, "1-10"],[2, "10-100"],[3, "100-1000"],[4, ">1000"]]

  TURNOVER_CURRENCY = {1 => "INR", 2 => "US$"}

  TURNOVER = {1 => "Less than Rs. 1 Crore", 2 => "Rs. 1-10 Crore", 3 => "Rs. 10-25 Crore", 4 => "Rs. 25-100 Crore", 5 => "Rs. 100-500 Crore", 6 => "Rs. 500 Crore and above"}


  # TURNOVER = [[1, "Less than 1 Crore"],[2, "1-10 Crore"],[3, "10-25 Crore"],[4, "25-100 Crore"], [5, ">100-500 Crore"], [6, "Less than 1 Million USD"], [7, "1-10 Million USD"], [8, "10-25 Million USD"], [9, "25-100 Million USD"], [10, ">100-500 Million USD"]]

end
