require 'test_helper'

class GuestsTest < ActionDispatch::IntegrationTest
  def setup
    @regular_user = regular_users(:user)
  end

  test 'login and make unsuccessful guest booking' do
    log_in_with @regular_user.email, 'password'
    click_link('Book Guests')
    assert page.has_content?('Add Guest Booking'), 'Guest Booking page was not rendered on selecting Book Guests link'
    fill_in('guest_user[names][]', with: 'SomeName')
    click_button('Book Guest')
    assert page.has_content?('Add Guest Booking'), 'Guest Booking page was not rerendered on submitting invalid data'
    assert page.has_content?('The form contains'), 'Error messages were not displayed on submitting invalid data'
  end

  test 'login and make successful guest booking and verify successful booking' do
    log_in_with @regular_user.email, 'password'
    click_link('Book Guests')
    assert page.has_content?('Add Guest Booking'), 'Guest Booking page was not rendered on selecting Book Guests link'
    fill_in('guest_user[names][]', with: 'Matt Murdock')
    fill_in('guest_user[from_date]', with: '20/3/2016')
    fill_in('guest_user[to_date]', with: '28/3/2016')
    click_button('Book Guest')

    assert page.has_content?('Booking Successful'), 'Appropriate flash message was not displayed on Successful booking'
    assert page.has_content?('View Guest Bookings')
    assert page.has_content?('Matt Murdock'), 'Name of new guest is not being displayed in Guest list'
  end
end
