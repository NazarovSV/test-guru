class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: 'You are not authorized to view this path.' unless current_user.is_a?(Admin)
  end

  def after_sign_in_path_for(_resource)
    admin_tests_url if current_user.is_a?(Admin)
  end
end
