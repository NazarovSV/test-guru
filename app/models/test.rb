class Test < ApplicationRecord
  belongs_to :category
  has_many :user_progresses
end
