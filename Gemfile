# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.4.1'
gem 'sass-rails', '~> 5.0'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'simple_form', '~> 5.0.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '~> 4.3.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'cancancan', '~> 2.0'
gem 'devise', '~>4.7.1'
gem 'haml', '~>5.0.4'
gem 'carrierwave', '~> 1.0'
gem 'active_model_serializers', '~> 0.10.7'
gem 'strip_attributes', '~> 1.8.0'
gem 'decent_exposure'
gem 'oj'
gem 'kaminari', '~> 1.1.1'
gem 'roo', '~> 2.8.2'
gem 'pumi', github: 'dwilkie/pumi', require: 'pumi/rails'
gem 'rubyzip', '~> 1.3.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'pry-rails', '0.3.6'
  gem 'rspec', '3.7.0'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'ffaker', '~> 2.8.0'
end

group :test do
  gem 'shoulda-matchers',       '~> 3.1.2'
  gem 'database_cleaner',       '~> 1.6.2'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 0.52.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate', '~> 2.7.2'
  # Use Capistrano for deployment
  gem 'capistrano',             '~> 3.10.1', require: false
  gem 'capistrano-rails',       '~> 1.3.1', require: false
  gem 'capistrano-rbenv',       '~> 2.1.3'
  gem 'capistrano-bundler',     '~> 1.3.0'
  gem 'capistrano-passenger',   '~> 0.2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
