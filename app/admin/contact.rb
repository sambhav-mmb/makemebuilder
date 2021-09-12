ActiveAdmin.register Contact do
	menu false

  actions :all, except: [:new, :create, :destroy]

  permit_params :call, :location

  form do |f|
    f.inputs do
      f.input :call, as: :ckeditor
      f.input :location, as: :ckeditor
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
        success.html { redirect_to session.delete(:return_to) }
      end
    end

  end
  
end