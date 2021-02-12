class Badge < ApplicationRecord
  RULES = %w[first_try hard_test easy_category].freeze

  validates :name, presence: true
  validates :rule_type, presence: true
end
