class RegularUsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:new, :create]

  def index
    unless current_user.admin?
      flash[:danger] = 'You are not authorized to access this page.'
      redirect_to regular_user_transactions_path(regular_user_id: current_user.id)
      return
    end
    @q = RegularUser.ransack(params[:q])
    @regular_users = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def new
    @regular_user = RegularUser.new
  end

  def create
    @regular_user = RegularUser.new(regular_user_params)
    if @regular_user.save
      log_in_user @regular_user
      flash[:success] = 'Welcome to IEMS - IIT Ropar'
      redirect_to regular_user_transactions_path(regular_user_id: @regular_user.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @regular_user.update_attributes(regular_user_params)
      flash[:success] = 'Profile updated successfully'
      redirect_to regular_user_transactions_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @regular_user.destroy
    flash[:success] = "#{@regular_user.name}'s account was deleted successfully"
    redirect_to regular_users_path
  end

  def authorize
    if @regular_user.update_attributes(regular_user_privilege_params)
      flash[:success] = 'User privileges updated successfully'
      redirect_to regular_users_path
    else
      render 'edit'
    end
  end

  private

  def regular_user_params
    params.require(:regular_user).permit(:name, :email, :password, :password_confirmation)
  end

  def regular_user_privilege_params
    params.require(:regular_user).permit(:admin, :manager)
  end
end
