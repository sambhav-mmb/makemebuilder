ActiveAdmin.register Uom do
	menu false
  config.filters = false

	action_item :new_uom, only: :show do
	  link_to 'New Uom', new_resource_path
	end

	permit_params :name, :uom_type_id

  # index do
  #   id_column
  #   column :name
  #   column "UOM Type", :uom_type, sortable: 'uom_types.name'
  #   actions
  # end

  controller do

    def index
      @page_title = "UOM"
      @uom_types = UomType.all
      render :layout => 'active_admin'
    end

    def scoped_collection
      resource_class.includes(:uom_type)
    end

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