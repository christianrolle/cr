# rubocop:disable all
source 'https://rubygems.org'
# rubocop:enable all

ruby '2.2.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'authlogic'
gem 'aws-sdk', '< 2.0'
gem 'bitly'
gem 'bootstrap-sass'
gem 'bootstrap3-datetimepicker-rails'
gem 'carrierwave', '~> 0.10.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'date_validator'
# Generates XML sitemaps dynamically
gem 'dynamic_sitemaps'
gem 'fog', require: 'fog/aws'
gem 'haml'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'kramdown'
gem 'middleman-syntax'
gem 'mini_magick', '~> 4.3'
gem 'momentjs-rails'
gem 'puma'
# When the Rack::Timeout limit is hit, it closes the requests and generates a
# stacktrace in the logs that can be used for future debugging of long running code
gem 'rack-timeout'
gem 'rails', '4.2.1'
gem 'rouge'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'turbolinks'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# schedules CRON jobs for example for updating sitemap.xml once a day
gem 'whenever'

group :production, :staging do
  # Use postgresql as the database for Active Record
  gem 'pg'
  # enables all platform features: https://devcenter.heroku.com/articles/rails-integration-gems
  # for more information.
  # This gem adds the rails_stdout_logging gem, which sends the logs to standard output.
  # This is useful in a production environment but not in development when Rails
  # already does it by default.
  gem 'rails_12factor'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'awesome_print'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'minitest-rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'rubocop', '~> 0.48.0', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :test do
  gem 'minitest'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
