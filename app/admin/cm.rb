ActiveAdmin.register Cm do
  menu false

  # action_item :import_demo, only: :show do
  #   link_to 'New Cm', new_resource_path
  # end

  permit_params :title, :desc, :image, cms_contents_attributes: [:id, :_destroy, :title, :desc, :icon, :rank, :status_id, :image]

  actions :all, except: [:new, :create, :destroy]

  index title: "Static Pages" do
    id_column
    column :title
    column :desc
    column "Image" do |c|
      image_tag c.image.try(:icon) unless c.image.nil?
    end
    actions
  end

  form do |f|

  	f.inputs :title, :desc, :image

  	f.inputs "Content" do
      f.has_many :cms_contents, allow_destroy: true do |j|
        j.input :title
        j.input :desc
        j.input :icon
        j.input :rank
        j.input :image
        j.input :status_id, as: :select, collection: {'Created': 1, 'Active': 2, 'Suspended': 3, 'Inactive/Canceled': 4, 'Hidden': 5, 'Deleted': 6}, include_blank:false
        j.actions
      end
    end

    f.actions 

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