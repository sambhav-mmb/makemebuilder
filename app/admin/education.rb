ActiveAdmin.register Education do

  menu false

	permit_params Education.attribute_names.map(&:to_sym)

end