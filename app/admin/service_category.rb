# ActiveAdmin.register ServiceCategory, as: "Category 1" do
ActiveAdmin.register ServiceCategory do
  menu false

  preserve_default_filters!
  filter :main_categories, as: :select, label: "Category 2", collection: ServiceCategory.form_select_main_categories
  filter :categories, as: :select, label: "Category 3", collection: ServiceCategory.form_select_categories
  filter :attributs, as: :select, label: "Attributes", collection: AttributeType.form_select_attributs

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("service_categories", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  # menu label: 'Category 1'

	config.sort_order = :rank

  permit_params :id, :short_name, :long_name, :tagline, :desc, :terms, :icon, :image, :rank, :status_id

  index title: 'Category 1' do
    id_column
    column :short_name
    column :long_name
    column :icon
    column :rank
    column :status
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