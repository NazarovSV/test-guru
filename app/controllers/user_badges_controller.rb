class UserBadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @user_badges = {}

    # UserBadge.each |user_badge| do
    #     user_badge.badge
    # end
    # @user_badges = UserBadge.where(user: current_user)
    @current_user_badges = UserBadge.where(user: current_user)
    badges_count = {}
    @current_user_badges.each do |user_badge|
      if badges_count.key? user_badge.badge
        badges_count[user_badge.badge][:count] += 1
      else
        badges_count[user_badge.badge] = { badge: user_badge.badge, count: 1 }
      end
    end

    @user_badges = badges_count.values
  end
end
