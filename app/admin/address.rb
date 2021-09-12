ActiveAdmin.register Address do

  menu false

	permit_params Address.attribute_names.map(&:to_sym)

end