require 'test_helper'

class RegularUserTest < ActiveSupport::TestCase
  def setup
    @regular_user = RegularUser.new( :name => "Example user", :email => "example@gmail.com", :password => "somepassword", :password_confirmation => "somepassword")
  end

  test "should be valid" do
    assert @regular_user.valid?
  end

  test "should respond to guest_users" do
    assert_respond_to @regular_user, :guest_users
  end

  test "name should not be blank" do
    @regular_user.name = "    "
    assert_not @regular_user.valid?
  end

  test "name should not be too long" do
    @regular_user.name = "a"*40 + "@example.com"
    assert_not @regular_user.valid?
  end

  test "name should not be too short" do
    @regular_user.name = "abc"
    assert_not @regular_user.valid?
  end

  test "email should not be blank" do
    @regular_user.email = "    "
    assert_not @regular_user.valid?
  end

  test "email should have the familiar email format" do
    @regular_user.email = "mynameisnishanth"
    assert_not @regular_user.valid?

    @regular_user.email = "valid.email@example.com"
    assert @regular_user.valid?
  end

  test "email should not be too long" do
    @regular_user.email = "a"*100 + "@example.com"
    assert_not @regular_user.valid?
  end

  test "password shouldn't be too small"  do
    @regular_user.password = @regular_user.password_confirmation = 'a'*5
    assert_not @regular_user.valid?
  end

  test "password and confirmation should match"  do
    @regular_user.password = "somepassword"
    @regular_user.password_confirmation = "someotherpassword"
    assert_not @regular_user.valid?
  end

  test "password cannot be blank"  do
    @regular_user.password = ""
    @regular_user.password_confirmation = ""
    assert_not @regular_user.valid?
  end

end
