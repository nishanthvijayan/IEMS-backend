require 'test_helper'

class GuestUserTest < ActiveSupport::TestCase
  def setup
    @guest_user = GuestUser.new( :name => "ExampleUser", :regular_user_id => 1, :from_date => '1995/8/28', :to_date => '1995/8/23' )
  end

  test "should be valid" do
    assert @guest_user.valid?
  end

  test "name should not be blank" do
    @guest_user.name = "    "
    assert_not @guest_user.valid?
  end

  test "name should not be too long" do
    @guest_user.name = "a"*40 + "@example.com"
    assert_not @guest_user.valid?
  end

  test "name should not be too short" do
    @guest_user.name = "abc"
    assert_not @guest_user.valid?
  end

  test "from_date should not be blank" do
    @guest_user.from_date = ""
    assert_not @guest_user.valid?
  end

  test "to_date should not be blank" do
    @guest_user.to_date = ""
    assert_not @guest_user.valid?
  end

end
