ActiveAdmin.register VendorLegal do

  menu false

	permit_params VendorLegal.attribute_names.map(&:to_sym)

end