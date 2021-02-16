# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :tests, dependent: :destroy

  validates :title, presence: true

  default_scope { order(title: :asc) }

  def simple?
    title == 'Простые'
  end
end
