require 'test_helper'

class HeaderTest < ActionDispatch::IntegrationTest
  test 'header renders properly for admins' do
    @admin_user = regular_users(:admin)
    log_in_with @admin_user.email, 'password'
    assert page.has_content?('Manage Users')
    assert page.has_content?('View Changes')
    assert page.has_content?('Manage Clients')
    assert page.has_content?('View Logs')
    assert page.has_content?('View Bookings')
    assert page.has_content?('Book Guests')
    assert page.has_content?(@admin_user.name)
  end

  test 'header renders properly for normal users' do
    @regular_user = regular_users(:user)
    log_in_with @regular_user.email, 'password'
    assert_not page.has_content?('Manage Users')
    assert_not page.has_content?('View Changes')
    assert_not page.has_content?('Manage Clients')
    assert page.has_content?('View Logs')
    assert page.has_content?('View Bookings')
    assert page.has_content?('Book Guests')
    assert page.has_content?(@regular_user.name)
  end

  test 'header renders properly for managers' do
    @manager_user = regular_users(:manager)
    log_in_with @manager_user.email, 'password'
    assert_not page.has_content?('Manage Users')
    assert_not page.has_content?('View Changes')
    assert page.has_content?('Manage Clients')
    assert page.has_content?('View Logs')
    assert page.has_content?('View Bookings')
    assert page.has_content?('Book Guests')
    assert page.has_content?(@manager_user.name)
  end
end
