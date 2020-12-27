# frozen_string_literal: true
require 'digest/sha1'
class User < ApplicationRecord
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

  def authenticate(password_string)
    digest(password_string) == password_digest ? self : false
  end

  private

  def digest(string)
    Digest::SHA1.hexdigest(string)
  end
end
