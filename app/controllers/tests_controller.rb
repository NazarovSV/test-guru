class TestsController < ApplicationController

  before_action :test_by_id, only: [:show]

  def index
    @tests = Test.all
  end

  def show; end

  private

  def test_by_id
    @test = Test.find(params[:id])
  end

end
