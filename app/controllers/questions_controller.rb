class QuestionsController < ApplicationController

  before_action :find_question_by_id, only: [:show]
  before_action :find_question_by_id_and_test_id, only: [:remove]
  before_action :find_question_by_test_id, only: [:index]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render json: { questions: @questions }
  end

  def show
    render json: { question: @question }
  end

  def new; end

  def create
    Question.create! body: params[:question][:body], test_id: params[:test_id]
    render plain: 'Test was created!'
  end

  def choose_question_for_remove; end

  def remove
    if @questions.any?
      Question.destroy params[:id]
      render html: '<h1>Question was deleted!</h1>'.html_safe
    else
      render plain: 'Question not found!'
    end
  end

  private

  def find_question_by_id
    @question = Question.find(params[:id])
  end

  def find_question_by_id_and_test_id
    @questions = Question.where(id: params[:id], test_id: params[:test_id])
  end

  def find_question_by_test_id
    @questions = Question.find_by_test_id!(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'question was not found'
  end

end
