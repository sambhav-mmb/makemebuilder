ActiveAdmin.register Category do
  menu false
  preserve_default_filters!
  filter :service_category_in, as: :select, label: "Category 1", collection: ServiceCategory.all
  filter :main_category, as: :select, label: "Category 2", collection: ServiceCategory.form_select_main_categories
  filter :uom, as: :select, label: "UOM", collection: UomType.form_select_uoms
  filter :attributs, as: :select, label: "Attributes", collection: AttributeType.form_select_attributs
  filter :type, as: :select, label: "Type", collection: Category::TYPE_REVERSE
  remove_filter :service_category
  remove_filter :attributables

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("categories", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  # menu label: 'Category 3'

	config.sort_order = :rank

  permit_params :id, :main_category_id, :name, :tagline, :desc, :terms, :uom_id, :icon, :image, :rank, :status_id, :type, :meta_title, :meta_description, :meta_keywords,
    :attributables_attributes => [:id, :_destroy, :attributable_type, :attributable_id, :attribute_id, :rank]
    # :attribut_ids => []

  index title: "Category 3" do
    selectable_column
    id_column
    column "Category 1", :service_category, sortable: 'service_categories.short_name'
    column "Category 2", :main_category, sortable: 'main_categories.short_name'
    column :name
    column "Type" do |t|
      t.type_name
    end
    column :uom
    column "Icon" do |c|
      image_tag c.icon.try(:icon) unless c.icon.nil?
    end
    column :rank
    column :status, sortable: 'statuses.name'
    actions
  end

  show do
    attributes_table :meta_keywords, :meta_title, :meta_description, :main_category, :name, :tagline, :desc, :terms, :uom_id, :icon, :image, :rank, :status, :type, :created_at, :updated_at

    panel "Attributes" do
      table_for resource.attributs do
        column nil do |attribute|
          attribute.name
        end
      end
    end
  end

  form do |f|
    # f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :meta_keywords
      f.input :meta_title
      f.input :meta_description
      f.input :status, include_blank: false
      f.input :main_category_id, as: :select, collection: option_groups_from_collection_for_select(ServiceCategory.all, :main_categories, :name, :id, :name, resource.main_category_id)
      f.input :name
      f.input :type, as: :radio, collection: Category::TYPE_REVERSE
      f.input :tagline
      f.input :desc
      f.input :terms
      f.input :uom_id, as: :select, collection: option_groups_from_collection_for_select(UomType.all, :uoms, :name, :id, :name, resource.uom_id)
      # f.input :uom_id, as: :select, collection: Uom.all
      f.input :icon, as: :file, hint: (image_tag(f.object.icon.url(:icon)) rescue nil)
      f.input :image
      f.input :rank
      # f.input :attributs, :as => :check_boxes
    end

    # if params[:action] == "edit" || params[:action] == "update"
    #   f.inputs "Attributes" do
    #     f.input :attributs, :as => :check_boxes
    #   end
    # end

    if params[:action] == "edit" || params[:action] == "update"
      f.inputs "Attributes" do
        f.has_many :attributables, allow_destroy: true, heading: false, new_record: "Add More" do |item|
          # item.input :attribute_id, as: :select, collection: (Attribute.all), include_blank: false
          item.input :attribute_id, as: :select, collection: option_groups_from_collection_for_select(AttributeType.all, :attributs, :name, :id, :name, item.object.attribute_id), include_blank: false
          item.input :rank
        end
      end
    end

    f.actions 

  end

  controller do

    def scoped_collection
      resource_class.includes(:status, :main_category => [:service_category])
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