class UserBadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_badges = UserBadge.grouped_badges_with_quantity_by_user(current_user)
  end
end
