ActiveAdmin.register Expertise do

  menu false

	permit_params Expertise.attribute_names.map(&:to_sym)

end