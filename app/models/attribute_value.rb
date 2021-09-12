class AttributeValue < ApplicationRecord

  belongs_to :valueable, polymorphic: true
  belongs_to :attribut, class_name: "Attribute", foreign_key: "attribute_id"

end