source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'faker', '1.4.2'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem'bootstrap-sass', '3.2.0.0'
gem 'bcrypt', '~> 3.1.7'
gem 'will_paginate', '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'bootstrap-datepicker-rails'
gem 'ransack'
gem 'simplecov'
gem 'coveralls', require: false
gem 'cancancan', '~> 1.10'
gem 'responders', '~> 2.0'
gem 'active_model_serializers'
gem 'carrierwave', '~> 0.10.0'
gem 'paper_trail'
# Use Unicorn as the app server
# gem 'unicorn'

source 'https://rails-assets.org' do
  gem 'rails-assets-chartjs'
end

# gem 'capistrano-rails', group: :development
group :development, :test do
  gem 'sqlite3' , '1.3.9'
  gem 'byebug' , '3.4.0'
  gem 'web-console' , '2.0.0.beta3'
  gem 'spring', '1.1.3'
  gem 'rubocop'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace', '0.1.3'
  gem 'guard-minitest', '2.3.1'
  gem 'capybara'
  gem 'poltergeist'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
