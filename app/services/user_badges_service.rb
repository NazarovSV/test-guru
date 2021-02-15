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

  def successful_by_first_time?(_badge)
    @test_passage.successfully? && TestPassage.where(test: @test, user: @current_user).one?
  end

  def successful_by_level?(badge)
    @test_passage.successfully? &&
      Test.level_scope_exists?(badge.value) &&
      Test.send(badge.value).include?(@test_passage.test) &&
      TestPassage.where(test: @test, user: @current_user).any? { :successfully? }
  end

  def successful_by_category?(badge)
    UserBadge.where(badge: badge, user: @current_user).empty? &&
      @test.category.title == badge.value &&
      @test_passage.successfully? &&
      all_test_done?
  end

  def all_test_done?
    Test.where(category: @test.category).select(:id).each do |id|
      return false if TestPassage.where(test_id: id, user: @current_user).none? { :successfully? }
    end
    true
  end
end
