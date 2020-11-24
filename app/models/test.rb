class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :user_progresses, dependent: :destroy
  has_many :users, through: :user_progresses

  def self.test_names_by_category_name_sorted_desc(category_name)
    joins("JOIN categories ON tests.category_id = categories.id")
      .where(categories: {title: category_name})
      .order(title: :desc)
      .pluck(:title)
  end

end
