require 'test_helper'

class ChangelogTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = regular_users(:admin)
    @regular_user = regular_users(:user)
  end

  test 'changelog displays new guest booking' do
    log_in_with @regular_user.email, 'password'

    # Book a Guest
    click_link('Book Guests')
    assert page.has_content?('Add Guest Booking'), 'Guest Booking page was not rendered on selecting Book Guests link'
    fill_in('guest_user[names][]', with: 'Oliver Queen')
    fill_in('guest_user[from_date]', with: '20/3/2016')
    fill_in('guest_user[to_date]', with: '28/3/2016')
    click_button('Book Guest')
    click_link(@regular_user.name)
    click_link('Log Out')

    log_in_with @admin_user.email, 'password'

    # Book a Guest
    click_link('Book Guests')
    assert page.has_content?('Add Guest Booking'), 'Guest Booking page was not rendered on selecting Book Guests link'
    fill_in('guest_user[names][]', with: 'Matt Murdock')
    fill_in('guest_user[from_date]', with: '20/3/2016')
    fill_in('guest_user[to_date]', with: '28/3/2016')
    click_button('Book Guest')

    click_link('View Changes')
    assert page.has_content?('Michael Example booked a new guest.')
    assert page.has_content?('Admin Example booked a new guest.')
  end
end
