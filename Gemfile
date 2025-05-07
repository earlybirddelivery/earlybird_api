source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.1'

group :development, :test do
  gem 'dotenv-rails', require: 'dotenv/load'
  gem 'rubocop', '~> 1.18.0', require: false
  gem 'rubocop-performance', '~> 1.11.0', require: false
  gem 'rubocop-rails', '~> 2.11.0', require: false
end
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.6'

# Use Puma as the app server
gem 'active_model_serializers'
gem 'activerecord-import'
gem 'activerecord-postgis-adapter'
gem 'awesome_print'
gem 'blamer'
gem 'devise'
gem 'doorkeeper'
gem 'doorkeeper-jwt'
gem 'net-http'
gem "puma", "~> 6.4"
gem 'pundit'
gem 'razorpay'
gem 'rgeo'
gem 'twilio-ruby'
gem 'versionist', '~> 1.7'

# notifications
gem 'fcm'

# Job framework
gem 'sidekiq'
gem 'sidekiq-cron'

# active storage s3
gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false

# pagination
gem 'api-pagination'
gem 'kaminari'

# Cleaning up data gems
gem 'auto_strip_attributes', '~> 2.4'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'pg', '~> 1.5'


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # deployment
  gem 'capistrano',         require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
