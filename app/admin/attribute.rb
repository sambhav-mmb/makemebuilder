ActiveAdmin.register Attribute do
  menu false
  config.filters = false
  
	# remove_filter :attributables

  permit_params :id, :attribute_type_id, :name, :display_type, values: []

  # index do
  #   id_column
  #   column :name
  #   column :attribute_type
  #   column :display_type do |f| Attribute::DISPLAY_TYPE[f.display_type] end
  #   column :values
  #   # column "Category 3", :category
  #   actions
  # end

  form partial: "form"

  action_item :new_attribute, only: :show do
	  link_to 'New Attribute', new_resource_path
	end

  controller do
    
    def index
      @page_title = "Attributes"
      @attribute_types = AttributeType.all
      render :layout => 'active_admin'
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