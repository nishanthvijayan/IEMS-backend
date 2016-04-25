class GuestUsersController < ApplicationController
  load_and_authorize_resource
  before_action :upcoming_guest, only: [:update, :destroy]

  def index
    @q = GuestUser.accessible_by(current_ability).ransack(params[:q])
    @guest_users = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @regular_users = RegularUser.accessible_by(current_ability)

    respond_to do |format|
      format.html
      format.csv { send_data @guest_users.to_csv, filename: "#{current_user.name}-Guest-logs.csv" }
      format.xls
    end
  end

  def new
  end

  def create
    params[:guest_user][:names].each do |name|
      next if name.blank?
      @guest_user = GuestUser.new(guest_user_params)
      @guest_user.regular_user_id = current_user.id
      @guest_user.name = name

      if @guest_user.save
        flash[:success] = 'Booking Successful'
      else
        render 'new'
        return
      end
    end
    redirect_to guest_users_path
  end

  def edit
  end

  def update
    if @guest_user.update_attributes(guest_user_params)
      flash[:success] = 'Guest details updated successfully'
      redirect_to guest_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @guest_user.destroy
    flash[:success] = "#{@guest_user.name}'s booking was deleted successfully"
    redirect_to guest_users_path
  end

  private

  def upcoming_guest
    return if @guest_user.from_date > Date.current
    flash[:danger] = 'Bookings before current date cannot be modified/deleted'
    redirect_to guest_users_path
  end

  def guest_user_params
    params.require(:guest_user).permit(:name, :from_date, :to_date, :details)
  end
end
