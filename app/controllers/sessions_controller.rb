class SessionsController < ApplicationController
  before_action :logged_in, only: :new

  def new
  end

  def create
    user = RegularUser.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password].downcase)
      log_in_user(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid Credentials'
      render 'new'
    end
  end

  def destroy
    log_out_user
    flash[:success] = 'Successfully Logged Out'
    redirect_to root_path
  end

  private

  def logged_in
    redirect_to current_user if logged_in?
  end
end
