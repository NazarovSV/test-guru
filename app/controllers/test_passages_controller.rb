class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[gist show update result]

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    client = GistQuestionService.new(@test_passage.current_question)
    result = client.call

    if client.gist_created?
      gist_save(result.html_url)
      flash[:notice] = t('.success_html', url: result.html_url)
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def gist_save(url)
    Gist.create!(url: url, user_id: current_user.id,
                 question_id: @test_passage.current_question.id)
  end
end
