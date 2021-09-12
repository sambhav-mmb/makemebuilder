class AttributeType < ApplicationRecord

	has_many :attributs, dependent: :destroy, class_name: "Attribute", foreign_key: "attribute_type_id"

	validates_presence_of :name

  self.primary_key = "id"

	def self.form_select_attributs
    result = ""
    AttributeType.all.each do |attribute_type|
      result += "<optgroup label='#{attribute_type.name}'>"
      attribute_type.attributs.each do |attribut|
        result += "<option value='#{attribut.id}'>#{attribut.name}</option>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end

end