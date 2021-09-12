ActiveAdmin.register Team do
  menu false

	config.sort_order = :rank

  permit_params :id, :name, :designation, :desc, :linkedin_url, :image, :rank, :status_id

  index do
    id_column
    column :name
    column :designation
    column :linkedin_url
    column "Image" do |t|
      image_tag t.image.try(:icon) unless t.image.nil?
    end
    column :rank
    column :status, sortable: 'statuses.name'
    actions
  end

  controller do

    def scoped_collection
      resource_class.includes(:status)
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