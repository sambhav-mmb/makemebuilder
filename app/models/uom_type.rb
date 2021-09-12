class UomType < ApplicationRecord

	has_many :uoms, dependent: :destroy

	validates_presence_of :name

	def self.form_select_uoms
    result = ""
    UomType.all.each do |uom_type|
      result += "<optgroup label='#{uom_type.name}'>"
      uom_type.uoms.each do |uom|
        result += "<option value='#{uom.id}'>#{uom.name}</option>"
      end
      result += "</optgroup>"
    end
    result.html_safe
  end

end