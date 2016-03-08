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
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def log_in_as (user, options = {})
    password = options[:password] || 'password'
    if integration_test?
      post login_path, session: {email: user.email, password: password }
    else
      session[:regular_user_id] = user.id
    end
  end

  def integration_test?
    defined?( post_via_redirect )
  end

end

class ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false
  Capybara.current_driver = :selenium
  # Capybara.javascript_driver =  :poltergeist
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
  end

  def log_in_with( email, password )
    visit(login_path)
    fill_in( 'session[email]', :with => email )
    fill_in( 'session[password]', :with => password )
    click_button("Log In")
  end
  
end
