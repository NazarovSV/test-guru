class Test < ApplicationRecord
  belongs_to :category

  def self.test_names_by_category_name_sorted_desc(category_name)
    joins("JOIN categories ON tests.category_id = categories.id")
      .where(categories: {title: category_name})
      .order(title: :desc)
      .pluck(:title)
  end

end
