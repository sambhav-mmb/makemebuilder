ActiveAdmin.register Employment do

  menu false

	permit_params Employment.attribute_names.map(&:to_sym)

end