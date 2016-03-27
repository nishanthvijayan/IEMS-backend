class RegularUsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
    unless current_user.admin?
      flash[:danger] = 'You are not authorized to access  that page.Contact admin if you require this privilage.'
      redirect_to current_user
    end
    @regular_users = RegularUser.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    if current_user.admin? || current_user.manager?
      @transactions = Transaction.all
      @all_regular_users = RegularUser.all
      @all_guest_users = GuestUser.all
    else
      @transactions = Transaction.where(regular_user: @regular_user)
      @all_regular_users = [current_user]
      @all_guest_users = GuestUser.where(regular_user: @regular_user)
    end
  end

  def new
    @regular_user = RegularUser.new
  end

  def create
    @regular_user = RegularUser.new(regular_user_params)
    if @regular_user.save
      log_in_user @regular_user
      flash[:success] = 'Welcome to IEMS - IIT Ropar'
      redirect_to @regular_user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @regular_user.update_attributes(regular_user_params)
      flash[:success] = 'Profile updated successfully'
      redirect_to @regular_user
    else
      render 'edit'
    end
  end

  private

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'You must be logged in to access that page'
    redirect_to login_path
  end

  def correct_user
    @regular_user = RegularUser.find(params[:id])
    return if current_user?(@regular_user)
    flash[:danger] = 'You are not authorized to access that page'
    redirect_to current_user
  end

  def regular_user_params
    params.require(:regular_user).permit(:name, :email, :password, :password_confirmation)
  end
end
