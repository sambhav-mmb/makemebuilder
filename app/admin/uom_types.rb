ActiveAdmin.register UomType do
	menu false

  action_item :new_uom_type, only: :show do
	  link_to 'New Uom Type', new_resource_path
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
