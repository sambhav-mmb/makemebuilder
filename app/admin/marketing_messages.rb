ActiveAdmin.register MarketingMessage do
	menu false

  actions :all, except: [:new, :create, :destroy]
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

	permit_params :title

  index do
    id_column
    column :title
    actions
  end

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
