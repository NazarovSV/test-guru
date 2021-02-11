class FeedbacksMailer < ApplicationMailer
  default to: 'heroku.test.guru@yandex.ru',
          subject: -> { t('.feedback') }

  def forward
    @message = params[:message]
    @email = params[:email]
    mail from: @email
  end
end
