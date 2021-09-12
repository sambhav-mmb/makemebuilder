class Setting < ApplicationRecord

 	before_create :only_one_row

  private
  
	  def only_one_row
	    raise "You can create only one row of the Settings table" if Setting.count > 0
	  end

end