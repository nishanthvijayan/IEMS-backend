class RegularUsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:new, :create]

  def index
    unless current_user.admin?
      flash[:danger] = 'You are not authorized to access this page.'
      redirect_to current_user
      return
    end
    @regular_users = RegularUser.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @transactions = Transaction.accessible_by(current_ability)
    @guest_users = GuestUser.accessible_by(current_ability)
    @regular_users = RegularUser.accessible_by(current_ability)

    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{current_user.name}-logs.csv" }
      format.xls
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
