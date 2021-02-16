class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def default_url_options
    { lang: (I18n.locale unless I18n.locale == I18n.default_locale) }
  end

  protected

  def after_sign_in_path_for(user)
    flash[:notice] = t('.hi', first_name: user.first_name, last_name: user.last_name)
    if user.is_a?(Admin)
      admin_tests_url
    else
      super
    end
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
