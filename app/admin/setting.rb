ActiveAdmin.register Setting do
	menu false

  permit_params :checkout_terms, :meta_keywords, :meta_title, :meta_description

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