class CustomQuote < ApplicationRecord

	attr_accessor :service_category_id, :main_category_id

	belongs_to :category

	has_many :attribute_values, as: :valueable, dependent: :destroy
  accepts_nested_attributes_for :attribute_values

  validates_presence_of :first_name, :last_name, :email, :phone, :category_id

  mount_uploader :file, CustomQuoteFileUploader

  def name
  	first_name.to_s + " " + last_name.to_s
  end

end