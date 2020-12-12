class TestsController < ApplicationController

  def index
    render json: { test: Test.all }
  end

end
