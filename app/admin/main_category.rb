ActiveAdmin.register MainCategory do
  menu false

  preserve_default_filters!
  filter :service_category, as: :select, label: "Category 1", collection: ServiceCategory.all
  filter :categories, as: :select, label: "Category 3", collection: ServiceCategory.form_select_categories

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("main_categories", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  # menu label: 'Category 2'

	config.sort_order = :rank

  permit_params :id, :service_category_id, :short_name, :long_name, :tagline, :desc, :terms, :icon, :image, :rank, :status_id

  index title: 'Category 2' do
    id_column
    column "Category 1", :service_category, sortable: 'service_categories.short_name'
    column :short_name
    column "Icon" do |mc|
      image_tag mc.icon.try(:icon) unless mc.icon.nil?
    end
    column :rank
    column :status, sortable: 'statuses.name'
    actions
  end

  controller do

    def scoped_collection
      resource_class.includes(:status, :service_category)
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