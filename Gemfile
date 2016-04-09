source 'https://rubygems.org'

ruby '2.2.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'authlogic'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Puma as the app server
gem 'puma'
# Generates XML sitemaps dynamically
gem 'dynamic_sitemaps'
# schedules CRON jobs for example for updating sitemap.xml once a day
gem 'whenever'
gem 'date_validator'
gem 'bitly'
#gem 'paperclip', '~> 4.3'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.3'
gem 'aws-sdk', '< 2.0'
gem 'rouge'
gem 'kramdown'
gem 'middleman-syntax'
# When the Rack::Timeout limit is hit, it closes the requests and generates a stacktrace in the logs 
# that can be used for future debugging of long running code
gem 'rack-timeout'
# stages

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'haml'
gem 'bootstrap-sass'
gem 'momentjs-rails'#, '>= 2.9.0', :github => 'derekprior/momentjs-rails'
gem 'bootstrap3-datetimepicker-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

group :production, :staging do
  # Use postgresql as the database for Active Record
  gem "pg"
  # enables all platform features: https://devcenter.heroku.com/articles/rails-integration-gems for more information.
  # This gem adds the rails_stdout_logging gem, which sends the logs to standard output.
  # This is useful in a production environment but not in development when Rails already does it by default.
  gem 'rails_12factor'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
