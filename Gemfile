# frozen_string_literal: true
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.2', '< 6.0'
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails4-autocomplete'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'
gem 'puma'
gem 'ckeditor'
gem 'devise'
gem 'cancancan', '~> 1.10'
gem 'bootstrap-sass'
gem 'actionview-encoded_mail_to'
gem 'google-api-client'

gem 'rinku'

gem 'paperclip'
gem 'recaptcha', require: 'recaptcha/rails'

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano3-puma'
  gem 'capistrano-rbenv'
  # Access an IRB console on exception pages or by using <%= console %> in
  # views
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rescue'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'factory_bot_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end
