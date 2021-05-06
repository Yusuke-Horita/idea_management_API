class Category < ApplicationRecord
  has_many :ideas, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def self.get_category_id(category_name)
    category = find_by(name: category_name)
    category = create(name: category_name) if category.nil?
    category.id
  end
end
