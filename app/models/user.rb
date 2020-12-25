# frozen_string_literal: true

class User < ApplicationRecord
  # has_many :owned_tests, class_name: 'Test', dependent: :restrict_with_exception
  # has_many :user_progresses, dependent: :destroy
  # has_many :tests, through: :user_progresses

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :owned_tests, class_name: 'Test', foreign_key: :user_id, dependent: :restrict_with_exception

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def completed_tests_by_level(level)
    Test.joins('JOIN test_passages ON test_passages.test_id = tests.id')
        .where(test_passages: { user_id: id, current_question: nil }, level: level)
        .distinct
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
