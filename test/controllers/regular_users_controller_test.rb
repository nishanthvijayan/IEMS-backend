require 'test_helper'

class RegularUsersControllerTest < ActionController::TestCase
  def setup
    @regular_user = regular_users(:admin)
    @other_regular_user = regular_users(:user)
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @regular_user
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path
  end

  test 'should redirect update when not logged in' do
    patch :update, id: @regular_user, regular_user: {name: 'Test User', email: 'testregular_user@gmail.com', password: 'password', password_confirmation: 'password'}
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path
  end

  test 'should redirect edit when logged in as wrong regular_user' do
    log_in_as @other_regular_user
    get :edit, id: @regular_user
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page.'
    assert_redirected_to login_path
  end

  test 'should redirect update when logged in as wrong regular_user' do
    initial_email = @regular_user.email

    log_in_as @other_regular_user

    patch :update, id: @regular_user, regular_user: {email: 'testregular_userchanged@gmail.com'}

    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page.'
    assert_redirected_to login_path

    @regular_user.reload
    assert_equal @regular_user.email, initial_email
  end
end
