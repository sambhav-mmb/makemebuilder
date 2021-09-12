class User < ApplicationRecord
	include Statusable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  VENDOR_STATUS = {1 => "Incomplete", 2 => "Under Review", 3 => "Rejected", 4 => "Approved"}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, authentication_keys: [:login], reset_password_keys: [:login], confirmation_keys: [:login]

  attr_accessor :company_name, :skip_mobile_validation, :confirm_email

  attr_writer :login

	validates :mobile, presence: true, uniqueness: true, numericality: true, length: {minimum: 10, maximum: 10}, unless: :skip_mobile_validation, allow_blank: true

	has_many :wishlists, dependent: :destroy
	has_many :carts, dependent: :destroy
	has_many :orders, through: :carts

	has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, update_only: true

  has_one :business_profile, dependent: :destroy
  accepts_nested_attributes_for :business_profile, update_only: true

  has_one :vendor_legal, dependent: :destroy
  accepts_nested_attributes_for :vendor_legal, update_only: true

  has_one :expertise, dependent: :destroy
  accepts_nested_attributes_for :expertise, update_only: true

  has_one :capacity, dependent: :destroy
  accepts_nested_attributes_for :capacity, update_only: true

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  has_many :projects, dependent: :destroy
  accepts_nested_attributes_for :projects

  has_many :employments, dependent: :destroy
  accepts_nested_attributes_for :employments

  has_many :educations, dependent: :destroy
  accepts_nested_attributes_for :educations

  has_many :recent_products, dependent: :destroy

  has_many :user_status_trackings, dependent: :destroy

  before_create :set_username

  after_update :under_review
  before_save :vendor_status_date, if: :vendor_status_changed?

  devise :omniauthable, omniauth_providers: [:google_oauth2 , :facebook]
  mount_uploader :image, AvatarUploader

  def after_confirmation
    self.update(status_id: 2)
  end

  def login
    @login || self.mobile || self.email
  end

  def name
  	first_name.to_s + " " + last_name.to_s
  end

  def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    if conditions[:mobile].nil?
	      where(conditions).first
	    else
	      where(mobile: conditions[:mobile]).first
	    end
	  end
	end

 	def self.from_omniauth(auth)
	  user = User.where(provider: auth.provider, uid: auth.uid).first

	  if user.present?
	  	user.first_name = auth.info.first_name   # assuming the user model has a first_name
	    user.last_name = auth.info.last_name   # assuming the user model has a last_name

	    user.image = auth.info.image # assuming the user model has an image
	    user.save

	 elsif user = User.where(email: auth.info.email).first
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.save   

	  else
	  	user = User.new(provider: auth.provider, uid: auth.uid)
	  	user.email = auth.info.email
	    user.username = "#{auth.uid}-#{auth.provider}"
	    user.password = Devise.friendly_token[0,20]
	    # user.name = auth.info.name   # assuming the user model has a name
	    user.first_name = auth.info.first_name   # assuming the user model has a first_name
	    user.last_name = auth.info.last_name   # assuming the user model has a last_name

	    user.image = auth.info.image # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.

	    user.status_id = 2
	    user.skip_mobile_validation = true
	    user.skip_confirmation!
	    user.save
	  end
	  user
	end

	def set_username
		self.username = Time.now.to_i
	end

	def is_mobile_verified?
		self.otp_confirmed_at.present?
	end

	def generate_otp
		self.update(otp: rand.to_s[2..7], otp_confirmed_at: nil, otp_sent_at: Time.now)
	end

	def verify_otp
		self.update(otp: nil, otp_confirmed_at: Time.now, otp_sent_at: nil)
	end

	def default_address
		addresses.where(is_default: true).first
	end

	def is_freelancer?
		is_vendor? && self.vendor_type == 1
	end

	def is_company?
		is_vendor? && self.vendor_type == 2
	end

	def is_vendor?
		is_vendor == true
	end

	def is_not_vendor?
		!is_vendor?
	end

	def is_incomplete?
		self.vendor_status == 1
	end

	def country_name
    ISO3166::Country.find_country_by_country_code(self.country_code.gsub("+", "")).try(:name)
  end

  def under_review
  	if is_incomplete?
	  	if is_company?
	  		if (vendor_legal.present? && vendor_legal.is_completed?) && (expertise.present? && expertise.is_completed?) && (capacity.present? && capacity.is_completed?) && (projects.any? && projects.first.is_completed?)
	  			self.update(:vendor_status => 2, date: Date.today)
	  			UserMailer.under_review_mail(@user).deliver_now
	  			UserMailer.under_review_maill(@useradmin).deliver_now
	  		end
	    end
	    if is_freelancer?
	  		if (expertise.present? && expertise.is_completed?) && (projects.any? && projects.first.is_completed?) && (employments.any? && employments.first.is_completed?) && (educations.any? && educations.first.is_completed?)
	  			self.update(:vendor_status => 2, date: Date.today)
	  			UserMailer.under_review_mail(@user).deliver_now
	  			UserMailer.under_review_maill(@useradmin).deliver_now
	  		end
	    end
    end
	end

	def vendor_status_date
		self.date = Date.today
		UserStatusTracking.create(user_id: self.id, vendor_status: self.vendor_status, date: Date.today)
	end

	def categories_uom
		Category.where(id: expertise.expertise_areas).joins(:uom) rescue []
	end

end