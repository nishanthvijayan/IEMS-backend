require 'test_helper'

class GuestUsersControllerTest < ActionController::TestCase
  def setup
    @regular_user = regular_users(:admin)
    @other_regular_user = regular_users(:user)
    @guest_user = guest_users(:guest_one)
  end

  test 'should redirect new, index, edit, update when not logged in' do
    get :new
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path

    get :create
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path

    get :index
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path

    get :edit, id: @guest_user
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path

    patch :update, id: @guest_user, guest_user: {name: 'Test User'}
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page. Maybe you need to sign in?'
    assert_redirected_to login_path
  end

  test 'should redirect guest edit when logged in as wrong regular_user' do
    log_in_as @other_regular_user
    get :edit, id: @guest_user
    assert_not flash.empty?
    assert_equal flash[:danger], 'You are not authorized to access this page.'
    assert_redirected_to login_path
  end

  test 'should redirect update when logged in as wrong regular_user' do
    initial_name = @guest_user.name
    log_in_as @other_regular_user
    patch :update, id: @guest_user, guest_user: { name: 'Test User' }
    assert_equal flash[:danger], 'You are not authorized to access this page.'
    assert_redirected_to login_path
    @guest_user.reload
    assert_equal @guest_user.name, initial_name
  end
end
