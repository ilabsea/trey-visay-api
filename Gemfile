# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.1.7"
# Use mysql as the database for Active Record
gem "mysql2", ">= 0.3.18", "< 0.5"
# Use Puma as the app server
gem "puma", "~> 5.6.8"
# Use SCSS for stylesheets
# gem 'bootstrap-sass', '~> 3.4.1'
gem "bootstrap", "~> 4.5.2"

gem "sass-rails", "~> 5.0"
gem "sprockets-rails", require: "sprockets/railtie"
gem "simple_form", "~> 5.3.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes

# gem 'mini_racer', platforms: :ruby

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
gem "jquery-rails", "~> 4.4.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem "devise", "~> 4.8.1"
gem "omniauth-rails_csrf_protection", "~> 1.0.1"
gem "omniauth-google-oauth2", "~> 1.1.1"

gem "haml", "~>5.0.4"
gem "strip_attributes", "~> 1.8.0"
gem "decent_exposure"
gem "oj"

gem "remove_emoji", "~> 3.0.0"

# File upload
gem "carrierwave", "~> 2.2.5"

# Serialer
gem "active_model_serializers", "~> 0.10.13"

# Read excel
gem "roo", "~> 2.9.0"
# Write excel
gem "caxlsx", "~> 3.3.0"
gem "caxlsx_rails", "~> 0.6.3"

# Location
gem "pumi", require: "pumi/rails"

# Zip file
gem "rubyzip", "~> 1.3.0"

# Soft delete
gem "paranoia", "~> 2.6.1"

# Nested level
gem "awesome_nested_set", "~> 3.5.0"

# Oauth authentication
gem "doorkeeper", "~> 5.6.6"

# Background process
gem "sidekiq", "~> 7.1.3"

# Client request
gem "httparty", "~> 0.21.0"

# Permission
gem "pundit", "~> 2.3.0"

# Pagination
gem "pagy", "~> 6.0.2"

gem "wicked_pdf", "~> 2.7.0"
gem "wkhtmltopdf-binary", "~> 0.12.6.6"

# Cross-origin
gem "rack-cors", "~> 2.0.1"

# for daterange picker
gem "momentjs-rails", "~> 2.29.4.1"
gem "bootstrap-daterangepicker-rails", "~> 3.0.4"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

gem "psych", "< 4"

gem "sentry-ruby"
gem "sentry-rails"

gem "recaptcha", "~> 5.16.0"

# Protect the app from bad clients
gem "rack-attack", "~> 6.7.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "rspec"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "rspec-sidekiq"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "annotate"

  # Use Capistrano for deployment
  gem "capistrano",             "~> 3.10.1", require: false
  gem "capistrano-rails",       "~> 1.3.1", require: false
  gem "capistrano-rbenv",       "~> 2.1.3"
  gem "capistrano-bundler",     "~> 1.3.0"
  gem "capistrano-passenger",   "~> 0.2.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
