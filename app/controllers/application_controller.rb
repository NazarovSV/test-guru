class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(user)
    flash[:notice] = "Hi, #{user.first_name} #{user.last_name}"
    if user.is_a?(Admin)
      admin_tests_url
    else
      super
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
