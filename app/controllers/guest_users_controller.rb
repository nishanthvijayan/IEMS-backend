class GuestUsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [ :edit, :update ]

  def index
    if current_user.admin? or current_user.manager?
      @guest_users = GuestUser.all
      @regular_users = RegularUser.all
    else
      @guest_users = GuestUser.where(regular_user: current_user)
      @regular_users = [current_user]
    end
  end

  def new
    @guest_user = GuestUser.new
    @guest_user.regular_user = current_user
  end

  def create
  end

  def edit
  end

  def update
    if @guest_user.update_attributes(regular_user_params)
      flash[:success] = "Guest details updated successfully"
      redirect_to guests_path
    else
      render 'edit'
    end
  end

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "You must be logged in to access that page"
        redirect_to login_path
      end  
    end

    def correct_user
      @guest_user =  GuestUser.find(params[:id])
      @host_user = @guest_user.regular_user
      unless current_user?(@host_user)
        flash[:danger] = "You are not authorized to access that page"
        redirect_to current_user
      end
    end

    def guest_user_params
      params.require(:guest_user).permit(:name, :from_date, :to_date, :details)
    end

end
