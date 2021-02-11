class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  SUCCESS_RATE = 0.85

  def successfully?
    rate >= SUCCESS_RATE && completed?
  end

  def rate
    (correct_questions / (test.questions.count * 1.0)).round(4)
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def completed?
    current_question.nil?
  end

  def question_number
    test.questions.order(:id).index(current_question) + 1
  end

  def time_left
    (test.timer - (Time.now - created_at)).to_i
  end

  def timer?
    test.timer.present?
  end

  private

  def before_validation_set_current_question
    return unless test.present?

    self.current_question = if current_question.nil?
                              test.questions.first
                            else
                              test.questions.order(:id)
                                  .where('id > ?', current_question.id)
                                  .first
                            end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort unless answer_ids.nil?
  end

  def correct_answers
    current_question.answers.correct
  end
end
