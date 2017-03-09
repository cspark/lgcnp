source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'activerecord-oracle_enhanced-adapter', '~> 1.7.0'
gem 'ruby-oci8', '~> 2.2.2' # only for CRuby users
gem 'devise'
gem 'bootstrap-datepicker-rails'
gem 'iconv'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'kaminari'
gem 'rmagick', '~> 2.16.0'
gem 'rubyzip', '>= 1.0.0'
gem 'zip-zip'
gem 'axlsx', '~> 2.0'
gem "axlsx_rails"
gem 'whenever', :require => false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'
end

group :staging, :development do
  gem 'rack-cors', :require => 'rack/cors'
  gem 'unicorn', '~> 5.2.0'
end

group :production, :development do
  gem 'rack-cors', :require => 'rack/cors'
  gem 'unicorn', '~> 5.2.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
