class UserBadgesService
  def initialize(test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @current_user = test_passage.user
  end

  def issue_reward
    Badge.all.each do |badge|
      success = send("#{badge.rule_type.to_sym}?", badge)
      @current_user.badges << badge if success
    end
  end

  private

  def first_try?(_badge)
    @test_passage.successfully? && TestPassage.where(test: @test, user: @current_user).one?
  end

  def hard_test?(_badge)
    @test_passage.successfully? &&
      Test.hard.include?(@test_passage.test) &&
      TestPassage.where(test: @test, user: @current_user).any? { :successfully? }
  end

  def easy_category?(badge)
    UserBadge.where(badge: badge, user: @current_user).empty? &&
      @test.category.title == 'Простые' &&
      @test_passage.successfully? &&
      all_easy_test_done?
  end

  def all_easy_test_done?
    Test.id_with_easy_category.each do |id|
      return false if TestPassage.where(test_id: id, user: @current_user).none? { :successfully? }
    end
    true
  end
end
