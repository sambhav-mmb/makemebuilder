ActiveAdmin.register Profile do

	menu false

	permit_params Profile.attribute_names.map(&:to_sym)

end