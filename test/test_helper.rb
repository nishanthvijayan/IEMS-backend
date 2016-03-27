require 'simplecov'

if ENV['TRAVIS']
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  Coveralls.wear!('rails')
else
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'capybara/rails'

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)
module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def log_in_as(user)
      session[:regular_user_id] = user.id
    end
  end
end

module ActionDispatch
  class IntegrationTest
    self.use_transactional_fixtures = true
    # Capybara.current_driver = :selenium
    Capybara.javascript_driver = :poltergeist
    include Capybara::DSL

    def teardown
      Capybara.reset_sessions!
    end

    def log_in_with(email, password)
      visit(login_path)
      fill_in('session[email]', with: email)
      fill_in('session[password]', with: password)
      click_button('Log In')
    end
  end
end
