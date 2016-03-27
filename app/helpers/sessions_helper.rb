module SessionsHelper
  def log_in_user(user)
    session[:regular_user_id] = user.id
  end

  def current_user
    @current_user ||= RegularUser.find_by(id: session[:regular_user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out_user
    session.delete(:regular_user_id)
    @current_user = nil
  end
end
