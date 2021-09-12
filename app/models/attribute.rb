class Attribute < ApplicationRecord

  belongs_to :attribute_type

  # DISPLAY_TYPE = [[1, "Text Field"],[2, "Text Area"],[3, "Select Dropdown"],[4, "Radio Button"]]
  # DISPLAY_TYPE_REVERSE = [["Text Field", 1],["Text Area", 2],["Select Dropdown", 3],["Radio Button", 4]]

  DISPLAY_TYPE = {1=> "Text Field", 2=> "Text Area", 3=> "Select Dropdown", 4=> "Radio Button"}
  

  DISPLAY_AS = [[1, :string],[2, :text],[3, :select],[4, :radio]]


  has_many :attributables, dependent: :destroy
  has_many :attribute_values, dependent: :destroy
  

  validates_presence_of :name

  before_save :sanitize_array_fields

  def sanitize_array_fields
    self.values.reject!(&:empty?)
  end

  def display_as
    Attribute::DISPLAY_AS.select{|i| i.first == self.display_type}.last.last
  end

  def value(product)
    product.attribute_values.where(attribute_id: self.id).first.value rescue nil
  end

end