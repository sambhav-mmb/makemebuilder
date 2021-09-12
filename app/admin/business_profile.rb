ActiveAdmin.register BusinessProfile do

	menu false

	permit_params BusinessProfile.attribute_names.map(&:to_sym)

end