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
    successful_by_condition?(badge, -> { @test.level == badge.value.to_i }, { level: @test.level })
  end

  def successful_by_category?(badge)
    successful_by_condition?(badge, -> { @test.category.id == badge.value.to_i }, { category: @test.category })
  end

  def successful_by_condition?(badge, equal_value_condition, condition)
    UserBadge.where(badge: badge, user: @current_user).empty? &&
      @test_passage.successfully? &&
      equal_value_condition.call &&
      all_test_done?(condition)
  end

  def all_test_done?(condition)
    Test.where(condition).select(:id).each do |id|
      return false if TestPassage.where(test_id: id, user: @current_user).none? { :successfully? }
    end
    true
  end
end
