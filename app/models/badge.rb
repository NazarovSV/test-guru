class Badge < ApplicationRecord
  RULES = %w[first_try hard_test easy_category].freeze

  has_many :user_badges, dependent: :restrict_with_exception
  has_many :users, through: :user_badges

  validates :name, presence: true
  validates :rule_type, presence: true
end
