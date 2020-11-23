class Test < ApplicationRecord
  belongs_to :category

  def self.test_names_by_category_name_sorted_desc(category_name)
    category_ids = Category.where(title: category_name)
    Test.where(category_id: category_ids).order('title ASC').pluck(:title)
  end

end
