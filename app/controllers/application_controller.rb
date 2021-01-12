class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def authenticate_user!
    cookies[:origin_path] = request.fullpath
    redirect_to login_path, alert: 'Are you a Guru? Verify your Email and Password please' unless current_user
  end

  def logged_in?
    current_user.present?
  end
end
