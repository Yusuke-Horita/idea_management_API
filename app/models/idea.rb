class Idea < ApplicationRecord
  belongs_to :category
  validates :body, presence: true

  def self.get_ideas(category_name)
		if category_name.present?
      if category = Category.find_by(name: category_name)
        @ideas = category.ideas
      end
    else
      @ideas = all
    end
	end
end
