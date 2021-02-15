class Badge < ApplicationRecord
  enum rules: %w[successful_by_first_time successful_by_level successful_by_category].freeze

  has_many :user_badges, dependent: :restrict_with_exception
  has_many :users, through: :user_badges

  validates :name, presence: true
  validates :rule_type, presence: true
  validates :rule_type, inclusion: { in: rules.keys }
end
