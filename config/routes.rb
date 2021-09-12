Rails.application.routes.draw do

  # devise_for :users
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations", confirmations: 'users/confirmations'}
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  begin
    ActiveAdmin.routes(self)
  rescue Exception => e
    puts "ActiveAdmin: #{e.class}: #{e}"
  end
  
  # get 'pages/index'
	root "pages#index"
  #get "/pages/:show/:mainid/:category_id" => "blogs#category", as: :blogs_category
  get "/search" => "products#search"

  get "/ajaxValidateFieldUser" => "dashboard#verify_password"


  get "/about" => "pages#about"
  get "/how-we-work" => "pages#how_we_work"
  get "/wishlist" => "pages#wishlist"

  # get "/services" => "pages#services"
  get "/careers" => "pages#careers"
  get "/contact-us" => "pages#contact_us"
  post "/contact-us" => "pages#contact_us_submit"


  post "/quote" => "pages#quote", as: :quote
  post "/news_letter" => "pages#news_letter"
  get "/unsubscribe/:code" => "pages#unsubscribe"
  get "/sitemap" => "pages#sitemap"
  post "/get_in_touch" => "pages#get_in_touch"

  scope "blogs" do
    get "/" => "blogs#index"
    get "/:id" => "blogs#show", as: :blog
    get "/category/:service_category_id" => "blogs#service_category", as: :blogs_service_category
    get "/category/:service_category_id/:main_category_id" => "blogs#main_category", as: :blogs_main_category
    get "/category/:service_category_id/:main_category_id/:category_id" => "blogs#category", as: :blogs_category
  end

  resources :carts, only: :index do
    post :add_item
    post :update_item
    post :update_item_comment
    delete :delete_item_doc
    delete :remove_item
    get :review
    get :payment
    get :set_address
    get :edit_address
    get :new_address
    post :update_address
    get :set_billing_address
    get :new_billing_address
    get :edit_billing_address
    post :update_billing_address
  end

  resources :orders, only: :create

  resources :categories, only: :index do
    get "products"
    get "quote"
    post "custom_quote"
    get "get_main_categories"
    get "get_categories"

    get "/:main_category_id/:category_id/products" => "categories#products"
    get "/:main_category_id/:category_id/quote" => "categories#quote"


    # get "/get_main_category/:service_category_id" => "categories#get_main_category"
  end

  resources :products, only: :show do
  end

  get "/products/:service_category_id/:main_category_id/:category_id/:id" => "products#show", as: :show

  # scope "categories" do
  #   get "/:id/products" => "categories#products", as: :products
  # end
  

  namespace :dashboard do
    get '', action: :index
    post '/profile_pic/update', action: :update_profile_pic, as: :update_profile_pic
    post '/profile/update', action: :update_profile, as: :update_profile
    post '/mobile/update', action: :update_mobile, as: :update_mobile
    post '/otp/verify', action: :verify_otp, as: :verify_otp

    post '/update_password', action: :update_password, as: :update_password

    get "/address/new", action: :new_address, as: :new_address
    get "/address/:id/edit", action: :edit_address, as: :edit_address
    post '/address/create', action: :create_address, as: :create_address
    get "/address/:id/set_default_address", action: :set_default_address, as: :set_default_address
    delete "/address/:id", action: :delete_address, as: :delete_address
    post "create_vendor"
    post :business_profile
    post :expertise
    post :capacity
    post :legal

    get :new_project
    get "/project/:id/edit", action: :edit_project, as: :edit_project
    post :projects
    delete "/project/:id/edit", action: :delete_project, as: :delete_project

    get :new_employment
    get "/employment/:id/edit", action: :edit_employment, as: :edit_employment
    post :employments
    delete "/employment/:id/edit", action: :delete_employment, as: :delete_employment

    get :new_education
    get "/education/:id/edit", action: :edit_education, as: :edit_education
    post :educations
    delete "/education/:id/edit", action: :delete_education, as: :delete_education

    post "/wishlist/:id", action: :add_wishlist, as: :add_wishlist
    post "/deactivate", action: :deactivate, as: :deactivate
    post "/reactivate", action: :reactivate, as: :reactivate


  end

  resources :vendors do
    post :update
  end
  

  # Routes for Google authentication
 

  delete "remove_wishlist_item/:slug" => "dashboard#remove_wishlist_item", as: :remove_wishlist_item
  

  get "/get_states/:country" => "pages#get_states"
  get "/get_cities/:state/:country" => "pages#get_cities"
  get '/dashboard/preview_profile'
  get '/carts/payment'
  get '/career/:id' => "pages#career"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end