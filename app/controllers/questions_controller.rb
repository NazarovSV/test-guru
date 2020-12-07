class QuestionsController < ApplicationController

  before_action :find_question_by_id, only: [:show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render json: { questions: Question.all }
  end

  def show
    render json: { question: @question }
  end

  private

  def find_question_by_id
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'question was not found'
  end

end
