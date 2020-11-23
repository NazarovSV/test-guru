class User < ApplicationRecord

  def completed_tests_by_level(level)
    Test.joins("JOIN user_progresses ON user_progresses.test_id = tests.id")
        .where(user_progresses: {user_id: self.id, is_completed: true }, level: level)
  end

end
