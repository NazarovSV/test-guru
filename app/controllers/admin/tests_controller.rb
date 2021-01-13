class Admin::TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test, only: %i[show start]

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def show
    @questions = @test.questions
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  def create
    @test = current_user.owned_tests.new(test_params)
    if @test.save
      redirect_to admin_tests_url, notice: 'Test create successfully!'
    else
      render :new
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end
end
