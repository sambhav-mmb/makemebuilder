ActiveAdmin.register Blog do
  menu false

  action_item :new_blog, only: :show do
    link_to 'New Blog', new_resource_path
  end

  permit_params :id, :title, :desc, :image, :author, :category_id, :is_featured, :is_service_category_featured, :status_id, :main_category, :service_category, :meta_title, :meta_description, :meta_keywords,
    :images_attributes => [:id, :_destroy, :image, :imageable_type, :imageable_id],
    :videos_attributes => [:id, :_destroy, :you_tube, :videoable_type, :videoable_id]

  index do
    id_column
    column :title
    column :author
    column "Category 1", :service_category, sortable: 'service_categories.short_name'
    column "Category 2", :main_category, sortable: 'main_categories.short_name'
    column "Category 3", :category, sortable: 'categories.name'
    # column :is_featured
    # column :is_service_category_featured
    column :status, sortable: 'statuses.name'
    actions
  end

  form do |f|
    f.inputs do
      f.input :meta_keywords
      f.input :meta_title
      f.input :meta_description
      f.input :title
      f.input :desc, as: :ckeditor
      f.input :image
      f.input :author
      f.input :category_id, as: :select, collection: (ServiceCategory.form_select_categories(f.object)), label: "Category 3"
      # f.input :is_featured
      # f.input :is_service_category_featured
      f.input :status, include_blank: false
    end

    if params[:action] == "edit" || params[:action] == "update"
      f.inputs "Images" do
        f.has_many :images, allow_destroy: true, heading: false, new_record: "Add More" do |item|
          item.input :image
        end
      end

      f.inputs "Videos" do
        f.has_many :videos, allow_destroy: true, heading: false, new_record: "Add More" do |item|
          item.input :you_tube
        end
      end
    end


    f.actions 

  end

  show do
    attributes_table do
      row :meta_keywords
      row :meta_title
      row :meta_description
      row :title
      row :desc do |p|
        raw p.desc
      end
      row :image do |b|
        image_tag b.image
      end
      row :author
      row "Category 3" do resource.category end
      row :status
      row :created_at
      row :updated_at
    end
    
  end

  controller do

    def scoped_collection
      resource_class.includes(:status, :category => [:main_category => [:service_category]]) # prevents N+1 queries to your database
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