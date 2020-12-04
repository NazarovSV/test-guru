# frozen_string_literal: true

class User < ApplicationRecord
  has_many :owned_tests, class_name: 'Test', dependent: :restrict_with_exception
  has_many :user_progresses, dependent: :destroy
  has_many :tests, through: :user_progresses

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def completed_tests_by_level(level)
    Test.joins('JOIN user_progresses ON user_progresses.test_id = tests.id')
        .where(user_progresses: { user_id: id, is_completed: true }, level: level)
  end
end
