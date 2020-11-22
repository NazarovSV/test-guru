class Test < ApplicationRecord
  belongs_to :category
  has_many :user_progresses

  def self.sorted_desc_tests_name_by_category(category_name)
    joins(:category).where('categories.title = ?', category_name).order('tests.title DESC').pluck(:title)
  end

end
