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
    user_transaction = transactions(:regular)
    admin_transaction = transactions(:guest)

    ability = Ability.new(user)
    assert ability.can? :manage, user
    assert ability.can? :manage, user_guest
    assert ability.cannot? :manage, other_user
    assert ability.cannot? :manage, other_user_guest

    assert ability.can? :read, user_transaction
    assert ability.can? :getimage, user_transaction
    assert ability.cannot? :read, admin_transaction
    assert ability.cannot? :getimage, admin_transaction
    assert ability.cannot? :destroy, user_transaction
    assert ability.cannot? :update, user_transaction
  end

  test 'signed in as manager' do
    user = regular_users(:user)
    user_guest = guest_users(:guest_three)
    manager_user = regular_users(:manager)
    manager_user_guest = guest_users(:guest_two)
    admin_user = regular_users(:admin)
    admin_user_guest = guest_users(:guest_one)
    user_transaction = transactions(:regular)

    ability = Ability.new(manager_user)
    assert ability.can? :manage, manager_user
    assert ability.can? :manage, manager_user_guest
    assert ability.can? :read, user
    assert ability.can? :read, user_guest
    assert ability.can? :read, admin_user
    assert ability.can? :read, admin_user_guest

    assert ability.can? :read, user_transaction
    assert ability.can? :getimage, user_transaction
    assert ability.cannot? :destroy, user_transaction
    assert ability.cannot? :update, user_transaction
  end

  test 'signed in as admin' do
    user = regular_users(:user)
    user_guest = guest_users(:guest_three)
    manager_user = regular_users(:manager)
    manager_user_guest = guest_users(:guest_two)
    admin_user = regular_users(:admin)
    admin_user_guest = guest_users(:guest_one)
    user_transaction = transactions(:regular)
    admin_transaction = transactions(:guest)

    ability = Ability.new(admin_user)
    assert ability.can? :manage, user
    assert ability.can? :manage, user_guest
    assert ability.can? :manage, manager_user
    assert ability.can? :manage, manager_user_guest
    assert ability.can? :manage, admin_user
    assert ability.can? :manage, admin_user_guest
    assert ability.can? :manage, user_transaction
    assert ability.can? :manage, admin_transaction
  end
end
