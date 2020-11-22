class User < ApplicationRecord

  def tests_by_level(level)
    Test.where(level: level).joins(:user_progresses).where('user_progresses.user_id = ?', self.id).distinct.to_a
  end

end
