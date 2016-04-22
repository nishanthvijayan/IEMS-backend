require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test 'not signed in user' do
    user = RegularUser.new
    ability = Ability.new(user)
    assert ability.cannot? :manage, GuestUser
    assert ability.cannot? :manage, RegularUser
  end

  test 'signed in user' do
    user = regular_users(:user)
    user_guest = guest_users(:guest_three)
    other_user = regular_users(:manager)
    other_user_guest = guest_users(:guest_one)
    ability = Ability.new(user)
    assert ability.can? :manage, user
    assert ability.can? :manage, user_guest
    assert ability.cannot? :manage, other_user
    assert ability.cannot? :manage, other_user_guest
  end
end
