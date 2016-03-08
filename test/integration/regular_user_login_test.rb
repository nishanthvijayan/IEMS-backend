require 'test_helper'

class RegularUserLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @regular_user = RegularUser.create( name: "TestUser", email: "testregular_user@gmail.com", password: "password", password_confirmation: "password" )
  end

  test "invalid login creds should not cause the flash message to persist capybara"  do
    log_in_with "testregular_user@gmail.com", "not_password"
    assert page.has_content?("Invalid Credentials")
    assert page.has_content?("Log In")
    visit(signup_path)
    assert_not page.has_content?("Invalid Credentials")
  end

  test "login with valid credentials followed by logout" do
    log_in_with "testregular_user@gmail.com", "password"
    assert page.has_content?("Breakfast")
    click_link("TestUser")
    click_link("Log Out")
    assert page.has_content?("Log In")
    assert page.has_content?("Successfully Logged Out")
  end

end
