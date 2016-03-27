class RegularUsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:new, :create]

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

  def regular_user_params
    params.require(:regular_user).permit(:name, :email, :password, :password_confirmation)
  end
end
