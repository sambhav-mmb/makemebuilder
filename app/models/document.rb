class Document < ApplicationRecord
  belongs_to :docable, polymorphic: true
	# belongs_to :cart_item
  mount_uploader :doc, DocumentUploader
end
