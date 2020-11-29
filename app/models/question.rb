class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :body, presence: true
  validates :body, uniqueness: {scope: :test_id, message: 'Question must be unique for the same test'}
end
