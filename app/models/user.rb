class User < ApplicationRecord

  def completed_tests_by_level(level)
    user_completed_test_ids = UserProgress.where(user_id: self.id).pluck(:test_id)
    Test.where(level: level, id: user_completed_test_ids)
  end

end
