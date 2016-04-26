require 'test_helper'

class RegularUserEditTest < ActionDispatch::IntegrationTest
  def setup
    @regular_user = regular_users(:user)
  end

  test 'login and make unsuccessful edit' do
    log_in_with @regular_user.email, 'password'
    click_link(@regular_user.name)
    click_link('Settings')
    assert page.has_content?('Edit Details'), 'Edit page was not rendered on selecting Settings link'
    fill_in('regular_user[name]', with: ' ')
    click_button('Save Changes')
    assert page.has_content?('Edit Details'), 'Edit page was not rendered on submitting invalid data'
    assert page.has_content?('The form contains'), 'Error messages were not displayed on submitting invalid data'
  end

  test 'login and make successful edit and verify successful edit' do
    log_in_with @regular_user.email, 'password'
    click_link(@regular_user.name)
    click_link('Settings')
    assert page.has_content?('Edit Details'), 'Edit page was not rendered on selecting Settings link'
    fill_in('regular_user[name]', with: 'Changed Name')
    fill_in('regular_user[email]', with: 'changed@gmail.com')
    click_button('Save Changes')

    assert page.has_content?('Profile updated successfully')
    assert page.has_content?('Breakfast')
    assert page.has_content?('Changed Name')
  end

  test 'login as admin and make successful edit to another user profile and verify successful edit' do
    @admin_user = regular_users(:admin)
    log_in_with @admin_user.email, 'password'

    visit edit_regular_user_path(@regular_user)
    assert page.has_content?('Edit Details'), 'Edit page was not rendered on selecting Settings link'
    fill_in('regular_user[name]', with: 'Changed Name')
    fill_in('regular_user[email]', with: 'changed@gmail.com')
    click_button('Save Changes')

    assert page.has_content?('Profile updated successfully')
    assert page.has_content?('Breakfast')
    assert page.has_content?(@admin_user.name)

    visit regular_users_path
    assert page.has_content?('Changed Name')
  end

  test 'login as admin and make successful edit to another user privileges and verify successful edit' do
    @admin_user = regular_users(:admin)
    log_in_with @admin_user.email, 'password'

    visit edit_regular_user_path(@regular_user)
    assert page.has_content?('Edit Details'), 'Edit page was not rendered on selecting Settings link'

    check('Admin')
    click_button('Update Privileges')
    assert page.has_content?('User privileges updated successfully')

    @regular_user.reload
    assert @regular_user.admin?
  end
end
