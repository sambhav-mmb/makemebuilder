ActiveAdmin.register Project do

  menu false

	permit_params Project.attribute_names.map(&:to_sym)

end