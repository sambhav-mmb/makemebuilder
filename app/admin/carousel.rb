ActiveAdmin.register Carousel do
  menu false

  action_item :new_carousel, only: :show do
    link_to 'New Carousel', new_resource_path
  end

  permit_params :id, :name, :blog_id, :rank, :status_id,
    :carousel_sliders_attributes => [:id, :_destroy, :product_id, :name, :desc, :image, :link_name, :link_url, :rank, :status_id]

  index do
    id_column
    column :name
    column :blog, sortable: 'blogs.title'
    column :rank
    column :status, sortable: 'statuses.name'
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :rank
      # f.input :blog
      f.input :blog_id, as: :select, collection: (ServiceCategory.form_select_blogs(f.object)), label: "Blog"
      f.input :status, include_blank: false
    end

    f.inputs "Carousel Sliders" do
      f.has_many :carousel_sliders, allow_destroy: true, heading: false, new_record: "Add More" do |item|
        # item.input :name
        # item.input :desc
        # item.input :image
        # item.input :link_name
        # item.input :link_url
        # item.input :product
        item.input :product, as: :select, collection: (ServiceCategory.form_select_products(item.object))
        item.input :rank
    		item.input :status, include_blank: false
      end
    end

    f.actions 

  end

  controller do
    
    def scoped_collection
      resource_class.includes(:status, :blog)
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