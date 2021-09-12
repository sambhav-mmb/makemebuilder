ActiveAdmin.register JumboSlider do
	menu false

  permit_params :id, :name, :image, :url, :rank, :status_id, :product_id, :valid_till

  index do
    id_column
    column :name
    column "Icon" do |js|
      image_tag js.image.try(:icon) unless js.image.nil?
    end
    column "Filename" do |js|
      js.image.file.filename rescue nil
    end
    column :product
    column "Dimension" do |js|
      ::MiniMagick::Image.open(js.image.url)[:dimensions] rescue nil
    end
    column "Image Size (KB)" do |js|
      js.image.file.size/1000 rescue nil
    end
    column :valid_till
    column :rank
    column :status, sortable: 'statuses.name'
    column :created_at
    column :updated_at
    actions
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :image
      f.input :product, as: :select, collection: (ServiceCategory.form_select_products(f.object))
      f.input :valid_till
      f.input :rank
      f.input :status, include_blank: false
    end
    f.actions 
  end

  show do
    attributes_table do
      row :name
      row "Image" do image_tag resource.image end
      row "Filename" do resource.image.file.filename rescue nil end
      row :product
      row :valid_till
      row "Dimension" do ::MiniMagick::Image.open(resource.image.url)[:dimensions] rescue nil end
      row "Image Size (KB)" do resource.image.file.size/1000 rescue nil end
      row :rank
      row :status
      row :created_at
      row :updated_at
    end
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