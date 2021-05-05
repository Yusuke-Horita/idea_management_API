class Idea < ApplicationRecord
  belongs_to :category
  validates :body, presence: true

  def self.get_ideas(category_name)
		if category_name.present?
      if category = Category.find_by(name: category_name)
        unformatted_ideas = category.ideas
      end
    else
      unformatted_ideas = all
    end
    ideas = []
    if unformatted_ideas.present?
      unformatted_ideas.each do |idea|
        hash = {}
        hash[:id] = idea.id
        hash[:category] = idea.category.name
        hash[:body] = idea.body
        ideas << hash
      end
    end
    ideas
	end
end
