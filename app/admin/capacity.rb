ActiveAdmin.register Capacity do

  menu false

	permit_params Capacity.attribute_names.map(&:to_sym)

end