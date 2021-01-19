module QuestionsHelper
  def question_header(question)
    if question.new_record?
      t('custom_helper.question.create', title: @question.test.title)
    else
      t('custom_helper.question.edit', title: @question.test.title)
    end
  end
end
