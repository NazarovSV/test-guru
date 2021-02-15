# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: :level, message: 'title and level must be unique' }

  scope :simple, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  def self.test_names_by_category_name_sorted_desc(category_name)
    joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category_name })
      .order(title: :desc)
      .pluck(:title)
  end

  def self.level_scope_exists?(level_scope)
    level_scope.present? && %i[simple normal hard].include?(level_scope.to_sym)
  end
end
