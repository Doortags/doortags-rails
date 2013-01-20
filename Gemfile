source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'

gem 'devise'

gem 'resque'
gem 'haml-rails'
gem 'json'
gem 'mail'
gem 'twilio-ruby'

group :development do
  gem 'sqlite3'
  gem "better_errors"
  gem "binding_of_caller"
end

group :production do
  # MySQL or PostgreSQL?
  gem 'pg'
  gem 'thin'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'faker'

  gem 'factory_girl_rails'
end
