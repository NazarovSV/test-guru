class QuestionsController < ApplicationController

  before_action :find_question_by_id_and_test_id, only: [:remove]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = Question.where(test_id: params[:test_id])
  end

  def show
    question = Question.find(params[:id])
    render json: { question: question }
  end

  def new; end

  def create
    Question.create! body: params[:question][:body], test_id: params[:test_id]
    render plain: 'Test was created!'
  end

  def remove
    Question.where(id: params[:id], test_id: params[:test_id])
    if @questions.any?
      Question.destroy params[:id]
      render html: '<h1>Question was deleted!</h1>'.html_safe
    else
      render plain: 'Question not found!'
    end
  end

  def destroy
    Question.destroy params[:id]
    redirect_back fallback_location: :root_path
  end

  private

  def rescue_with_question_not_found
    render plain: 'question was not found'
  end

end
