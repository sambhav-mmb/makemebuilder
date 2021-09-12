class NewsLetter < ApplicationRecord

	before_create :generate_code

	scope :subscribed, -> {where(is_subscribed: true)}
	scope :unsubscribed, -> {where(is_subscribed: false)}

	def self.subscribe(email)
		news_letter = NewsLetter.find_or_initialize_by(email: email)
		news_letter.is_subscribed = true
		news_letter.save
		NewsLetterMailer.user_email(news_letter).deliver_later
  	NewsLetterMailer.admin_email(news_letter).deliver_later
	end

	def self.unsubscribe(code)
		news_letter = NewsLetter.find_by_code(code)
		if news_letter
			news_letter.update(is_subscribed: false)
		end
	end

	private

		def generate_code
			self.code = SecureRandom.urlsafe_base64(nil, false)
		end

end
