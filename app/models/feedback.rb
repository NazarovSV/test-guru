class Feedback
  include ActiveModel::Model

  attr_accessor :email, :message

  validates :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: :wrong_format }
end
