class User < ApplicationRecord
  has_many :created_tests, class_name: "Test"
  has_many :user_progresses
  has_many :tests, through: :user_progresses

  def completed_tests_by_level(level)
    Test.joins("JOIN user_progresses ON user_progresses.test_id = tests.id")
        .where(user_progresses: {user_id: self.id, is_completed: true }, level: level)
  end

end
