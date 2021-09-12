class AdminUser < ApplicationRecord

  ROLE = {"content_editor" => "Content editor", "user_manager" => "User manager", "vendor_manager" => "Vendor manager"}

  role_based_authorizable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
