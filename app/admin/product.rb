ActiveAdmin.register Product do
  menu false

  preserve_default_filters!
  filter :category, as: :select, label: "Category", collection: ServiceCategory.form_select_categories
  filter :uom_in, as: :select, label: "UOM", collection: UomType.form_select_uoms
  filter :attributs, as: :select, label: "Attributes", collection: AttributeType.form_select_attributs
  remove_filter :images
  remove_filter :cart_items
  remove_filter :recent_products
  remove_filter :wishlists
  remove_filter :attribute_values
  remove_filter :uoms

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "admin/csv/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    CsvDb.convert_save("products", params[:dump][:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end

  action_item :new_product, only: :show do
    link_to 'New Product', new_resource_path
  end

  action_item :only => :show do
    link_to("Duplicate", clone_admin_product_path(product))
  end

  member_action :clone, method: :get do
    product = Product.find(params[:id])
    @product = product.dup
    @product.name = nil
    render 'active_admin/resource/new.html.arb', :layout => false
  end

  permit_params :id, :name, :desc, :image, :image1, :image2, :image3, :image4, :price, :category_id, :type_of_product, :status_id, :terms_and_conditions, :full_price, :rank, :meta_title, :meta_description, :meta_keywords,
    :images_attributes => [:id, :_destroy, :image, :imageable_type, :imageable_id],
    :attribute_values_attributes => [:id, :attribute_id, :value, :valueable_type, :valueable_id],
    :uoms_attributes => [:id, :name, :value, :uomable_type, :uomable_id]

  index do
    selectable_column
    id_column
    column "Category 1", :service_category, sortable: 'service_categories.short_name'
    column "Category 2", :main_category, sortable: 'main_categories.short_name'
    column "Category 3", :category, sortable: 'categories.name'
    column :name
    column :full_price
    column "Offer Price", :price
    # column :uom
    column :status, sortable: 'statuses.name'
    column "Type", :type_name, sortable: :type_of_product
    # column :terms_and_conditions
    actions
  end

  show do
    attributes_table do
      row :meta_keywords
      row :meta_title
      row :meta_description
      row :name
      row "Category 1" do resource.service_category end
      row "Category 2" do resource.main_category end
      row "Category 3" do resource.category end
      row :desc do |p|
        raw p.desc
      end
      row :image do |p|
        image_tag p.image.url(:thumb)
        # image_tag p.image1.url(:thumb)
        # image_tag p.image2.url(:thumb)
        # image_tag p.image3.url(:thumb)
        # image_tag p.image4.url(:thumb)
      end
      row :price
      row :full_price
      # row :uom
      row :status
      row "Type" do resource.type_name end
      row :terms_and_conditions
      row :rank
      row :created_at
      row :updated_at
    end
    panel "Attributes" do
      table_for resource.attribute_values do
        column "name" do |attribute_value|
          attribute_value.attribut.name
        end
        column "value" do |attribute_value|
          attribute_value.value
        end
      end
    end
  end

  # form partial: "form"

  form do |f|
    f.inputs do
      f.input :meta_keywords
      f.input :meta_title
      f.input :meta_description
      f.input :name
      f.input :desc, as: :ckeditor
      f.input :image
      # f.input :image1
      # f.input :image2
      # f.input :image3
      # f.input :image4
      f.input :price, wrapper_html: {class: 'static-text-list'}, hint: "#{f.object.uom.present? ? '/' + f.object.uom.name.to_s : ''}"
      f.input :full_price, wrapper_html: {class: 'static-text-list'}, hint: "#{f.object.uom.present? ? '/' + f.object.uom.name.to_s : ''}"
      f.input :category_id, as: :select, collection: (ServiceCategory.form_select_categories(f.object)), label: "Category 3"
      # f.input :uom_id, as: :select, collection: Uom.all
      f.input :status, include_blank: false
      # f.input :type_of_product, as: :select, collection: Product::TYPE.invert, include_blank: false
      f.li do
        f.label :parent_terms
        f.span f.object.parent_terms, class: "static-text"
      end
      f.input :terms_and_conditions
      f.input :rank
    end
       
    

    if params[:action] == "edit" || params[:action] == "update"
      f.inputs "Images" do
        f.has_many :images, allow_destroy: true, heading: false, new_record: "Add More" do |item|
          item.input :image
        end
      end

      f.inputs "Attributes" do
        # counter = 0
        f.has_many :attribute_values, heading: false, new_record: false do |item|
          # resource.attributs.each_with_index do |aa, index|
            # if counter == index
              aa = item.object.attribut
              item.input :value, label: aa.name, iopp: "wd", as: aa.display_as, collection: (aa.values), include_blank: false
              item.input :attribute_id, as: :hidden
            # end
          # end
          # counter += 1
        end
      end
    end

    


    # resource.attributs.each_with_index do |aa, index|
    #   f.input :price
    # end

    # f.inputs "Attributes" do
    #   f.has_many :attribute_values, allow_destroy: true, heading: false do |item|
    #     item.input :value#, label: item.object.attribute_id
    #   end
    # end

    # render 'form', context: self, f: f

    # f.inputs "Attributes" do




    #   resource.category.attributs.each_with_index do |aa, index|
    #     if aa.display_type == 1
    #       f.input :price, name: "product[attribute_values_attributes][#{index - 1}][value]", label: aa.name

    #       # f.text_field :name, name: "ss"
    #     elsif aa.display_type == 2
    #       f.input :name, as: :text, name: "ss", label: aa.name

    #       # f.text_area :name, name: "ss"
    #     elsif aa.display_type == 3
    #       f.input :category_id, as: :select, collection: (aa.values), label: aa.name, include_blank: false
    #       # f.select :name, name: "ss"
    #     else
    #       f.input :category_id, as: :radio, collection: (aa.values), label: aa.name, include_blank: false
    #     end
    #   end
    # end

    f.actions 

  end

  controller do

    def scoped_collection
      resource_class.includes(:status, :category => [:main_category => [:service_category]])
    end

    def edit
      # @product = resource
      session[:return_to] ||= request.referer
      resource.attributs.each do |attribut|
        unless resource.attribute_values.where(attribute_id: attribut.id).present?
          resource.attribute_values.create(attribute_id: attribut.id)
          # @product.attribute_values.build(attribute_id: attribut.id)
        end
      end
      resource.attribute_values.where.not(attribute_id: resource.attributs.map(&:id)).destroy_all
    end

    def update
      super do |success,failure|
        success.html { redirect_to session.delete(:return_to) }
      end
    end

  end

end