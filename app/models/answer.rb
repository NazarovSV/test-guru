class Answer < ApplicationRecord
  belongs_to :question

  validates :variant, :question_id, presence: true
  validates :variant, uniqueness: {scope: :question_id, message: 'Answer must be unique for the same question'}
  validate :validate_number_of_the_answers_in_question

  scope :correct, -> {where(correct: true)}

  def validate_number_of_the_answers_in_question
    errors.add(:base, :invalid, message: "The question can have no more than 4 answer") unless Answer.where(question_id: question_id).count <= 4
  end


end
