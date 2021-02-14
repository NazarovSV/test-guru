class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  def self.grouped_badges_with_quantity_by_user(user)
    @current_user_badges = UserBadge.where(user: user)
    badges_count = {}
    @current_user_badges.each do |user_badge|
      if badges_count.key? user_badge.badge
        badges_count[user_badge.badge][:count] += 1
      else
        badges_count[user_badge.badge] = { badge: user_badge.badge, count: 1 }
      end
    end
    badges_count.values
  end
end
