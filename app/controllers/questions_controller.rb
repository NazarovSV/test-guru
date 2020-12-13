class QuestionsController < ApplicationController

  before_action :question_by_id, only: %i[show destroy edit update]
  before_action :find_test_by_id, only: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    redirect_to test_url(id: params[:test_id])
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to test_url(id: @test.id)
    else
      render :edit
    end
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to test_url(id: @test.id)
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to test_url(@question.test_id)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def question_by_id
    @question = Question.find(params[:id])
    @test = @question.test
  end

  def find_test_by_id
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'question was not found'
  end

end
