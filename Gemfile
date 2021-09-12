source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server

gem 'puma', '~> 3.7'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'sqlite3', '~> 1.4', '>= 1.4.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  gem 'thin'
end

group :production do
end

gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]




# gem 'bootstrap-sass'

gem 'bootstrap', '~> 4.1.1'
gem 'bootstrap-glyphicons'
# gem 'sprockets-rails', :require => 'sprockets/railtie'

gem 'font-awesome-rails'
gem 'jquery-rails'
gem 'slim'
gem 'figaro'
gem 'devise'


# gem 'oa-oauth', :require => 'omniauth/oauth'
# gem 'omniauth'

gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-cas', github: 'CruGlobal/omniauth-cas' # has single sign out fix
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'omniauth-linkedin'

gem 'activeadmin'
# gem 'active_skin'
gem 'active_admin_role'
gem 'carrierwave'
gem 'fog'
gem "mini_magick" #required for converted images
gem 'city-state'
gem 'friendly_id'
gem 'activerecord-session_store'
gem 'acts_as_shopping_cart'
gem 'simple_form'
gem 'ckeditor'
gem 'social-share-button', '~> 1.2.0'
gem 'countries'
gem "select2-rails"
gem "haml-rails"
gem 'activerecord-reset-pk-sequence'
# gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'
gem 'country_select', '~> 3.1'
gem 'country_state_select'
gem 'instagram'
gem 'omniauth-instagram'
gem 'truncato'
gem 'remotipart'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'bootstrap-datepicker-rails'
gem 'exception_notification'
gem "koala"
