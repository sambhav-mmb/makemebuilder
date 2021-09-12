ActiveAdmin.register Order do

  menu false

  config.filters = false

  actions :index, :show, :edit, :update

  permit_params :id, :status, :comment

  index title: "Enquiries" do
    id_column
    column :name
    column :mobile
    column :state
    column :city
    column "Enquired On" do |o|
      o.created_at.strftime("%d/%b/%Y")
    end
    column "Enquiry Total" do |o|
      "#{o.cart.total.currency.symbol}#{o.cart.total}"
    end
    column "Status" do |o|
      Order::STATUS[o.status]
    end
    column :comment
    actions
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Order::STATUS.invert, include_blank: false
      f.input :comment
    end
    f.actions
  end

  controller do
    
    def show
      @page_title = "Enquiry - #{resource.id}"
      @order = resource
      render :layout => 'active_admin'
    end

  end

end