FactoryBot.define do
  factory :idea do
    body { Faker::Lorem.sentence(word_count: 3) }
    association :category
  end
end
