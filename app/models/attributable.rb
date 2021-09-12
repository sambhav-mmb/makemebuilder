class Attributable < ApplicationRecord

  belongs_to :attributable, polymorphic: true
  belongs_to :attribut, class_name: "Attribute", foreign_key: "attribute_id"

  validates_presence_of :attribute_id
  validates :attributable, presence: true

  validates :attribute_id, uniqueness: {scope: [:attributable_id, :attributable_type]}

	default_scope {order(:rank)}

end