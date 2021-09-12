class DashboardController < ApplicationController

  before_action :authenticate_user!, except: [:add_wishlist]
  before_action :set_current_user

  def index
  end

  def update_profile_pic
    @user.update(user_params)
    redirect_to params[:user][:url]
  end

  def update_profile
  	if @user.update(user_params)
      flash.now[:success] = "Your profile has been updated successfully!"
      if params[:user][:user_type] == "vendor"
        redirect_to "#{dashboard_path}?user_type=#{params[:user][:user_type]}"
      else
        redirect_to dashboard_path
      end
    else
      flash.now[:error] = "Your profile has not been updated!"
      render "index"
    end
  end

  def update_mobile
    @user.errors.add(:mobile, "has already been taken") if @user.mobile == params[:user][:mobile]
  	if @user.errors.blank? && @user.update(user_params)
      @user.generate_otp
      @is_updated = true
    end
  end

  def verify_otp
    @user.errors.add(:otp, "incorrect") if @user.otp != params[:user][:otp]
    @user.errors.add(:password, "incorrect") unless @user.valid_password?(params[:user][:password])
    if @user.errors.blank? && @user.verify_otp
      @is_updated = true
      flash.now[:success] = "Your mobile has been verified successfully!"
    else
      flash.now[:error] = "Your mobile has not been verified!"
    end
  end

  def verify_password
    if @user.valid_password?(params[:fieldValue])
      render json: ["user_old_password", true , ""]
    else
      render json: ["user_old_password", false , "The old password is wrong"]
    end
  end

  def update_password
    if params[:user][:password] == params[:user][:password_confirmation]
      @user.update(password: params[:user][:password])
      flash[:success] = "Password has been successfully changed!"
      redirect_to dashboard_path
    end
  end

  def new_address
    @address = Address.new
    set_new_address
    render "edit_address"
  end

  def edit_address
    @address = Address.find(params[:id])
    set_edit_address(@address.country, @address.state)
  end

  def create_address
    if @user.update(user_params)
      flash[:success] = "Your address has been updated successfully!"
    else
      flash[:error] = "Your address has not been updated!"
    end
    redirect_to dashboard_path
  end

  def set_default_address
    @address = Address.find(params[:id])
    if @address.user == current_user
      current_user.addresses.update_all(is_default: false)
      @address.update(is_default: true)
      flash[:success] = "Your address has been updated successfully!"
    else
      flash[:error] = "Your address has not been updated!"
    end
    redirect_to dashboard_path
  end

  def delete_address
    @address = Address.find(params[:id])
    if @address.user == current_user && @address.present?
      @address.destroy
      flash[:success] = "Your address has been deleted successfully!"
    else
      flash[:error] = "Your address can not be deleted!"
    end
    redirect_to dashboard_path
  end

  def create_vendor
    if @user.update(is_vendor: true, vendor_created_at: Time.now)
      flash[:success] = "You successfully became a Vendor!"
      redirect_to dashboard_path(user_type: "vendor")
    else
      flash[:error] = "You cannot become a Vendor!"
      redirect_to dashboard_path
    end
  end

  def expertise
    if @user.update(user_params)
      flash.now[:success] = "Your expertise has been updated successfully!"
    else
      flash.now[:error] = "Your expertise has not been updated!"
    end
  end

  def business_profile
    if @user.update(user_params)
      flash.now[:success] = "Your Business Profile has been updated successfully!"
    else
      flash.now[:error] = "Your Business Profile has not been updated!"
    end
  end

  def legal
    if @user.update(user_params)
      # @user.vendor_legal.update(legal_areas: params[:user][:legal_attributes][:legal_areas].split)
      flash.now[:success] = "Your legal has been updated successfully!"
    else
      flash.now[:error] = "Your legal has not been updated!"
    end
  end

  def capacity
    if @user.update(user_params)
      flash.now[:success] = "Your capacity has been updated successfully!"
    else
      flash.now[:error] = "Your capacity has not been updated!"
    end
  end

  def new_project
    @project = Project.new
    set_new_address
    render "edit_project"
  end

  def edit_project
    @project = Project.find(params[:id])
    set_edit_address(@project.country, @project.state)
  end

  def projects
    if @user.update(user_params)
      flash.now[:success] = "Your project has been updated successfully!"
    else
      flash.now[:error] = "Your project has not been updated!"
    end
  end

  def delete_project
    @project = Project.find(params[:id])
    if @project.destroy
      flash.now[:success] = "Your project has been deleted successfully!"
    else
      flash.now[:error] = "Your project has not been deleted!"
    end
    render "projects"
  end

  def new_employment
    @employment = Employment.new
    render "edit_employment"
  end

  def edit_employment
    @employment = Employment.find(params[:id])
  end

  def employments
    if @user.update(user_params)
      flash.now[:success] = "Your employment has been updated successfully!"
    else
      flash.now[:error] = "Your employment has not been updated!"
    end
  end

  def delete_employment
    @employment = Employment.find(params[:id])
    if @employment.destroy
      flash.now[:success] = "Your employment has been deleted successfully!"
    else
      flash.now[:error] = "Your employment has not been deleted!"
    end
    render "employments"
  end

  def new_education
    @education = Education.new
    render "edit_education"
  end

  def edit_education
    @education = Education.find(params[:id])
  end

  def educations
    if @user.update(user_params)
      flash.now[:success] = "Your education has been updated successfully!"
    else
      flash.now[:error] = "Your education has not been updated!"
    end
  end

  def delete_education
    @education = Education.find(params[:id])
    if @education.destroy
      flash.now[:success] = "Your education has been deleted successfully!"
    else
      flash.now[:error] = "Your education has not been deleted!"
    end
    render "educations"
  end

  def add_wishlist
    @product = Product.find(params[:id])
    if user_signed_in?
      existing_wishlist = current_user.wishlists.where(product_id: @product.id)
      if existing_wishlist.present?
        flash.now[:error] = "Product is already in your Wishlist!"
      else
        current_user.wishlists.create(product_id: @product.id)
        flash.now[:success] = "Product has been added to your Wishlist!"
      end
    else
      flash[:error] = "You need to sign in or sign up before continuing."
    end
  end

  def remove_wishlist_item
    @product = Product.find_by(slug: params[:slug])
    current_user.wishlists.where(product_id: @product.id).first.destroy
    flash[:success] = "Product is removed from your wishlists"
    respond_to do |format|
      format.html { redirect_to(wishlist_url) }
      format.js
    end
  end

  def deactivate
    if @user.update(is_vendor: false)
      flash[:success] = "You successfully deactivated your seller profile!"
    else
      flash[:error] = "You cannot deactivate your seller profile!"
    end
    redirect_to dashboard_path
  end

  def reactivate
    if @user.update(is_vendor: true)
      flash[:success] = "You successfully reactivated your seller profile!"
    else
      flash[:error] = "You cannot reactivate your seller profile!"
    end
    redirect_to dashboard_path
  end

  private

    def set_new_address
      @countries = CS.countries.map{|c| [c.last, c.last]}
      country_code = CS.countries.to_a.select{|i| i[1] == "India"}[0][0]
      @states_hash = CS.states(country_code)
      @states_hash[:AN] = "Andaman and Nicobar Islands"
      @states_hash[:PY] = "Puducherry"
      @states_hash[:CT] = "Chhattisgarh"
      @states_hash[:HP] = "Himachal Pradesh"
      @states_hash[:JH] = "Jharkhand"
      @states_hash[:PB] = "Punjab"
      @states_hash[:DL] = "Delhi"
      @states_hash[:LD] = "Lakshadweep"
      @states = CS.states(country_code).map{|c| [c.last, c.last]}
      @cities = {}
    end

    def set_edit_address(country, state)
      country = "India" if country.nil?
      state = "Delhi" if state.nil?
      @countries = CS.countries.map{|c| [c.last, c.last]}
      country_code = CS.countries.to_a.select{|i| i[1] == country}[0][0]
      @states_hash = CS.states(country_code)
      @states = CS.states(country_code).map{|c| [c.last, c.last]}
      if country == "India"
        state_code = :AN if state == "Andaman and Nicobar Islands"
        state_code = :PY if state == "Puducherry"
        state_code = :CT if state == "Chhattisgarh"
        state_code = :HP if state == "Himachal Pradesh"
        state_code = :JH if state == "Jharkhand"
        state_code = :PB if state == "Punjab"
        state_code = :DL if state == "Delhi"
        state_code = :LD if state == "Lakshadweep"
      else
        state_code = @states_hash.to_a.select{|i| i[1] == state}[0][0]
      end
      @cities = CS.cities(state_code, country_code)
    end

    def set_current_user
      @user = current_user
      @is_updated = false
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :linkedin, :facebook, :twitter, :google, :pintrest, :instagram, :image, :mobile, :vendor_type, :country_code,
        profile_attributes: [:gender, :dob, :marital_status, :website],
        expertise_attributes: [:id, :name, :credentials, :desc, :tagline, :certifications, :certification_number, :describe => [], :expertise_areas => []],
        business_profile_attributes: [:company_name, :owner_ceo_name, :owner_ceo_mobile, :landline, :logo, :linkedin, :facebook, :twitter, :google, :pintrest, :instagram],
        vendor_legal_attributes: [:company_type_id, :incorporation_date, :cin, :gstn, :pan],
        capacity_attributes: [:graduates, :diploma_holders, :masters_and_phd, :uom_id, :skilled_workers, :turnover, :volume, :year, :tagline, :turnover_currency],
        addresses_attributes: [:id, :name, :mobile, :address_line_1, :address_line_2, :landmark, :country, :state, :city, :zip_code, :address_type, :others],
        projects_attributes: [:id, :name, :type, :other_type, :developer, :location, :configuration, :completion_date, :star_rating, :desc, :company_name, :contact_person, :contact_person_mobile, :country, :state, :city, :builtup_area, :capacity],
        employments_attributes: [:id, :name, :role, :join_date, :end_date, :desc],
        educations_attributes: [:id, :education, :other_education, :board, :name, :year_of_graduation, :degree, :specialization, :other_specialization, :institute]
      )
    end

end