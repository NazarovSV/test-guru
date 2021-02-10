class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.valid?
      FeedbacksMailer.with(message: @feedback.message, email: @feedback.email).forward.deliver_now
      flash[:notice] = t('.success')
      redirect_to root_path
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :message)
  end
end
