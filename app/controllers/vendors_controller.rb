class VendorsController < ApplicationController

  before_action :set_vendor

	def show
	end

	def create
		if params[:commit] == "Freelancer" || params[:commit] == "Company"
			if params[:commit] == "Freelancer" && @vendor.update(vendor_type: 1, is_vendor: true, vendor_created_at: Time.now)
				@next = "vendors/educations"
			elsif params[:commit] == "Company" && @vendor.update(vendor_type: 2, is_vendor: true, vendor_created_at: Time.now)
				@next = "vendors/legals"
	    else
	    end
    end
    render "registration"
	end

	def update
		if @vendor.update(user_params)
      @vendor.expertise.update(expertise_areas: params[:user][:expertise_attributes][:expertise_areas].split) if params[:user][:expertise_attributes].present?
    else
    end
	end

	private

		def set_vendor
      @vendor = current_user
    end

		def user_params
      params.require(:user).permit(
        vendor_legal_attributes: [:company_type_id, :incorporation_date, :cin, :gstn, :pan],
        expertise_attributes: [:id, :name, :credentials, :desc, :tagline, :certifications, :certification_number, :describe => [], :expertise_areas => []],
        capacity_attributes: [:graduates, :diploma_holders, :masters_and_phd, :uom_id, :skilled_workers, :turnover, :volume, :year, :tagline, :turnover_currency],
        addresses_attributes: [:id, :name, :mobile, :address_line_1, :address_line_2, :country, :state, :city, :zip_code],
        projects_attributes: [:id, :name, :type, :other_type, :developer, :location, :configuration, :completion_date, :star_rating, :desc, :company_name, :contact_person, :contact_person_mobile, :country, :state, :city, :builtup_area, :capacity],
        employments_attributes: [:id, :name, :role, :join_date, :end_date, :desc],
        educations_attributes: [:id, :education, :other_education, :board, :name, :year_of_graduation, :degree, :specialization, :other_specialization, :institute]
      )
    end

end