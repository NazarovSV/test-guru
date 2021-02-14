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

  #Проверяется, что тест пройден успешно с первого раза
  #Повторно за тот же тест получить награду нельзя
  def first_try?(_badge)
    @test_passage.successfully? && TestPassage.where(test: @test, user: @current_user).one?
  end

  #Проверяется, что пройден сложный тест с lvl > 5
  #можно повторно за тот же тест получить бадж
  def hard_test?(_badge)
    @test_passage.successfully? &&
      Test.hard.include?(@test_passage.test) &&
      TestPassage.where(test: @test, user: @current_user).any? { :successfully? }
  end

  #Проверяется, что пройдены все тесты легкой категории
  #Повторно получить нельзя
  def easy_category?(badge)
    UserBadge.where(badge: badge, user: @current_user).empty? &&
      @test.category.simple? &&
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
