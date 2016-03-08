require 'test_helper'

class GuestUsersControllerTest < ActionController::TestCase

  def setup
    @regular_user = RegularUser.create( name: "TestUser", email: "testregular_user@gmail.com", password: "password", password_confirmation: "password", admin: true )
    @other_regular_user = RegularUser.create( name: "OtherUser", email: "othertestregular_user@gmail.com", password: "password", password_confirmation: "password" )
    @guest_user = GuestUser.create( :name => "ExampleUser", :regular_user => @regular_user, :from_date => '1995/8/28', :to_date => '1995/8/23' )
  end

  test "should redirect new, index, edit, update when not logged in" do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_path 

    get :index
    assert_not flash.empty?
    assert_redirected_to login_path

    get :edit, id: @guest_user
    assert_not flash.empty?
    assert_redirected_to login_path

    patch :update, id: @guest_user, guest_user: {name: "Test User"}
    assert_not flash.empty?
    assert_redirected_to login_path 
  end

  test "should redirect guest edit when logged in as wrong regular_user" do
    log_in_as @other_regular_user, password: "password"
    get :edit, id: @guest_user
    assert_not flash.empty?
    assert_redirected_to @other_regular_user
  end

  test "should redirect update when logged in as wrong regular_user" do
    log_in_as @other_regular_user, password: "password"
    patch :update, id: @guest_user, guest_user: { name: "Test User" }
    @guest_user.reload
    assert_equal @guest_user.name, "ExampleUser"
    assert_redirected_to @other_regular_user
  end

end
