ActiveAdmin.register EmailTemplate do
  menu false

  actions :all, except: [:new, :create, :destroy]
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :custom_email, :contact_us_email, :vendor_approved_email, :vendor_reject_email, :news_letter_user_email, :news_letter_admin_email, :get_in_touch_user_email, :get_in_touch_admin_email, :quote_user_email, :quote_admin_email, :confirmation, :checkout_mail, :under_review_user, :under_review_admin, :email_changed, :password_changed, :reset_password, :unlock_instructions

  index do
    id_column
    column :custom_email
    column :contact_us_email
    column :vendor_approved_email
    column :vendor_reject_email
    column :news_letter_user_email
    column :news_letter_admin_email
    column :get_in_touch_user_email
    column :get_in_touch_admin_email
    column :quote_user_email
    column :quote_admin_email
    column :confirmation
    column :under_review_user
    column :under_review_admin
    actions
  end

  form do |f|
    f.inputs do
      f.input :custom_email, as: :ckeditor
      f.input :contact_us_email, as: :ckeditor
      f.input :vendor_approved_email, as: :ckeditor
      f.input :vendor_reject_email, as: :ckeditor
      f.input :news_letter_user_email, as: :ckeditor
      f.input :news_letter_admin_email, as: :ckeditor
      f.input :quote_user_email, as: :ckeditor
      f.input :quote_admin_email, as: :ckeditor
      f.input :confirmation
      f.input :checkout_mail
      f.input :get_in_touch_user_email, as: :ckeditor
      f.input :get_in_touch_admin_email, as: :ckeditor
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
        success.html { redirect_to session.delete(:return_to) } if session[:return_to].present?
      end
    end

  end

end