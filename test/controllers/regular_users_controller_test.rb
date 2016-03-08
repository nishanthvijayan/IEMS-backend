require 'test_helper'

class RegularUsersControllerTest < ActionController::TestCase

  def setup
    @regular_user = RegularUser.create( name: "TestUser", email: "testregular_user@gmail.com", password: "password", password_confirmation: "password", admin: true )
    @other_regular_user = RegularUser.create( name: "OtherUser", email: "othertestregular_user@gmail.com", password: "password", password_confirmation: "password" )
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @regular_user
    assert_not flash.empty?
    assert_redirected_to login_path 
  end

  test "should redirect update when not logged in" do
    patch :update, id: @regular_user, regular_user: {name: "Test User", email: "testregular_user@gmail.com", password: "password", password_confirmation: "password"}
    assert_not flash.empty?
    assert_redirected_to login_path 
  end

  test "should redirect edit when logged in as wrong regular_user" do
    log_in_as @other_regular_user, password: "password"
    get :edit, id: @regular_user
    assert_not flash.empty?
    assert_redirected_to @other_regular_user
  end

  test "should redirect update when logged in as wrong regular_user" do
    log_in_as @other_regular_user, password: "password"
    patch :update, id: @regular_user, regular_user: {name: "Test User", email: "testregular_userchanged@gmail.com"}
    @regular_user.reload
    assert_equal @regular_user.email, "testregular_user@gmail.com"
    assert_equal @regular_user.name, "TestUser"
    assert_redirected_to @other_regular_user
  end

end
