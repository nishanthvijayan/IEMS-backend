class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_paper_trail_whodunnit

  add_flash_types :danger

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    message = exception.message
    message << ' Maybe you need to sign in?' unless current_user
    redirect_to login_path, danger: message
  end
end
