require 'test_helper'

class RegularUserSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    visit signup_path
    assert_no_difference 'RegularUser.count' do
      fill_in "regular_user[name]" , :with => "example"
      fill_in "regular_user[email]" , :with =>  "not_valid_email"
      fill_in "regular_user[password]" , :with =>  "password"
      fill_in "regular_user[password_confirmation]" , :with =>  "password"
      click_button "Create my account"
    end
    assert page.has_content?("Sign Up")
  end

  test "password and confirmation should be same for valid signup" do
    visit signup_path
    assert_no_difference 'RegularUser.count' do
      fill_in "regular_user[name]" , :with => "example"
      fill_in "regular_user[email]" , :with =>  "niceguy@example.com"
      fill_in "regular_user[password]" , :with =>  "password"
      fill_in "regular_user[password_confirmation]" , :with =>  "not_password"
      click_button "Create my account"
    end
    assert page.has_content?("Sign Up")
  end

  test "valid signup information" do
    visit signup_path
    assert_difference 'RegularUser.count', 1 do
      fill_in "regular_user[name]" , :with => "example"
      fill_in "regular_user[email]" , :with =>  "niceguy@example.com"
      fill_in "regular_user[password]" , :with =>  "password"
      fill_in "regular_user[password_confirmation]" , :with =>  "password"
      click_button "Create my account"
    end
    assert page.has_content?("Breakfast")
  end

end
