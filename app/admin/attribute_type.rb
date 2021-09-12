ActiveAdmin.register AttributeType do
	menu false

  action_item :new_attribute_type, only: :show do
	  link_to 'New Attribute Type', new_resource_path
	end

	permit_params :name

	controller do

    def edit
      session[:return_to] ||= request.referer
      super
    end

    def update
      super do |success,failure|
        success.html { redirect_to session.delete(:return_to) }
      end
    end

  end

end