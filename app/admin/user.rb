ActiveAdmin.register User do
  menu false

  preserve_default_filters!
  remove_filter :wishlists
  remove_filter :carts
  remove_filter :orders
  remove_filter :profile
  remove_filter :business_profile
  remove_filter :vendor_legal
  remove_filter :expertise
  remove_filter :capacity
  remove_filter :addresses
  remove_filter :projects
  remove_filter :employments
  remove_filter :educations
  remove_filter :recent_products
  remove_filter :user_status_trackings
  remove_filter :encrypted_password
  remove_filter :reset_password_token
  remove_filter :reset_password_sent_at
  remove_filter :remember_created_at
  remove_filter :confirmation_token
  remove_filter :image

  action_item :new_user, only: :show do
    link_to 'New User', new_resource_path
  end

  permit_params :email, :first_name, :last_name, :linkedin, :facebook, :twitter, :google, :pintrest, :instagram, :image, :mobile, :status_id, :vendor_status, :date


  index do
    selectable_column
    id_column
    column :username
    column :email
    column :provider
    column :first_name
    column :last_name
    # column :linkedin
    # column :facebook
    # column :twitter
    # column :google
    # column :pintrest
    # column :instagram
    column :mobile
    column :status, sortable: 'statuses.name'
    column :vendor_status
    column :date
    # actions
    actions do |user|
      item "Profile", admin_profile_path(user.profile), class: "member_link" if user.profile.present?

      if user.is_freelancer?
        item "Employments", "/admin/employments?q[user_id_eq]=#{user.id}&commit=Filter", class: "member_link"
        item "Educations", "/admin/educations?q[user_id_eq]=#{user.id}&commit=Filter", class: "member_link"
        item "Expertise", admin_expertise_path(user.expertise), class: "member_link" if user.expertise.present?
        item "Projects", "/admin/projects?q[user_id_eq]=#{user.id}&commit=Filter", class: "member_link"
      end
      if user.is_company?
        item "Business Profile", admin_business_profile_path(user.business_profile), class: "member_link" if user.business_profile.present?
        item "Legal", admin_vendor_legal_path(user.vendor_legal), class: "member_link" if user.vendor_legal.present?
        item "Expertise", admin_expertise_path(user.expertise), class: "member_link" if user.expertise.present?
        item "Projects", "/admin/projects?q[user_id_eq]=#{user.id}&commit=Filter", class: "member_link"
        item "Capacity", admin_capacity_path(user.capacity), class: "member_link" if user.capacity.present?
      end
      item "Addresses", "/admin/addresses?q[user_id_eq]=#{user.id}&commit=Filter", class: "member_link"

    end
  end

  show do
    attributes_table :username, :email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :confirmed_at, :provider, :uid, :first_name, :last_name, :linkedin, :facebook, :twitter, :google, :pintrest, :instagram, :image, :country_code, :mobile, :status, :vendor_status, :date

    panel "Profile" do
      table_for resource.profile do
        column :name
        column :state
      end
    end

    # table_for resource.addresses.order('name ASC') do
    #   column "Profile" do |category|
    #     category.name
    #   end
    #   column "Profile" do |category|
    #     category.state
    #   end
    # end



  end

  # show title: :name do
  #   render "show", context: self
  # end

  form do |f|
    f.inputs "user Details" do
      f.input :email
      # f.input :password
      f.input :first_name 
      f.input :last_name
      f.input :linkedin
      f.input :facebook
      f.input :twitter
      f.input :google
      f.input :pintrest
      f.input :instagram
      f.input :image
      f.input :status
      f.input :mobile 
      f.input :vendor_status, as: :select, collection: {'Incomplete': 1, 'Under_Review': 2, 'Rejected':3, 'Approved':4}, include_blank: false, default: 1
      f.input :date, start_year: 1990, include_blank: false
    end
    f.actions 
  end

  controller do

    def edit
      session[:return_to] ||= request.referer
      super
    end

    def update
      @user = User.find(params[:id])
      super do |success,failure|
        if params[:user][:vendor_status]=="3"
          UserMailer.user_reject(@user).deliver_now
        elsif params[:user][:vendor_status]=="4"
          UserMailer.user_approved(@user).deliver_now
        else
        end
        success.html { redirect_to session.delete(:return_to) }
      end
    end

    def scoped_collection
      resource_class.includes(:status)
    end

  end

end