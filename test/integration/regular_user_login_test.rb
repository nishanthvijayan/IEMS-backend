require 'test_helper'

class RegularUserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @regular_user = regular_users(:user)
  end

  test 'invalid login creds should not cause the flash message to persist capybara' do
    log_in_with @regular_user.email, 'notpassword'
    assert page.has_content?('Invalid Credentials')
    assert page.has_content?('Log In')
    visit(signup_path)
    assert_not page.has_content?('Invalid Credentials')
  end

  test 'login with valid credentials followed by logout' do
    log_in_with @regular_user.email, 'password'
    assert page.has_content?('Breakfast')
    click_link(@regular_user.name)
    click_link('Log Out')
    assert page.has_content?('Log In')
    assert page.has_content?('Successfully Logged Out')
  end
end
