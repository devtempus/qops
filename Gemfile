source 'https://rubygems.org'

gem 'rails', '4.2.6'

### DB ###
gem 'mysql2'

### API ###
gem 'rabl'
gem 'versionist'
# gem 'rocket_pants'

### Frontend ###
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jbuilder', '~> 2.0'

gem 'haml', '~> 4.0.7'
gem 'haml-rails', '~> 0.9.0'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootswatch-rails', '~> 3.3.4'

gem 'rest-client', '~>1.8.0'

gem 'font-awesome-rails'
gem 'async-rails'
gem 'responders'

gem 'ancestry'

gem 'bootstrap-wysihtml5-rails', '~> 0.3.3.8'

gem 'will_paginate', '~> 3.1.0'

group :development do
  gem 'puma', '~> 3.6.0'

  ### Capistrano for deployment ###
  gem 'capistrano', '~> 3.5.0'
  gem 'capistrano-rails', '~> 1.1.7'
  gem 'capistrano-bundler', '~> 1.1.4'
  gem 'capistrano-rvm', '~> 0.1.2'

  ### For debuging ###
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'meta_request'
  gem 'better_errors', '~> 2.1.0'
  gem 'binding_of_caller'
  gem 'rubocop', require: false
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl'
  gem 'simplecov', require: false
  gem 'byebug'
end

group :production do
  # gem 'unicorn' #server
end