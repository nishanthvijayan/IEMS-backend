class GuestUsersController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.admin? || current_user.manager?
      @guest_users = GuestUser.all
      @regular_users = RegularUser.all
    else
      @guest_users = GuestUser.where(regular_user: current_user)
      @regular_users = [current_user]
    end

    respond_to do |format|
      format.html
      format.csv { send_data @guest_users.to_csv, filename: "#{current_user.name}-Guest-logs.csv" }
      format.xls
    end
  end

  def new
    @guest_user = GuestUser.new(regular_user: current_user)
  end

  def create
    @guest_user = GuestUser.new(guest_user_params)
    @guest_user.regular_user_id = current_user.id
    if @guest_user.save
      flash[:success] = 'Booking Successful'
      redirect_to guest_users_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @guest_user.update_attributes(regular_user_params)
      flash[:success] = 'Guest details updated successfully'
      redirect_to guests_path
    else
      render 'edit'
    end
  end

  private

  def guest_user_params
    params.require(:guest_user).permit(:name, :from_date, :to_date, :details)
  end
end
