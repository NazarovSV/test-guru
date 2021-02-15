class UserBadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_badges = current_user.badges
  end
end
