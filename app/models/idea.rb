class Idea < ApplicationRecord
  belongs_to :category
  validates :body, presence: true

  def self.get_ideas(category_name)
    if category_name.present?
      category = Category.find_by(name: category_name)
      category.ideas if category.present?
    else
      all
    end
  end
end
