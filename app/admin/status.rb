ActiveAdmin.register Status do
	menu false
  permit_params :code, :name, :color, :bgcolor, :rank, :notes

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