FactoryBot.define do
  factory :review do
    restaurant_id { nil }
    reviewer      { Faker::Name.name }
    review        { Faker::Restaurant.review }
    rating        { Faker::Number.between(from: 1, to: 3) }
    association :restaurant, factory: :restaurant
  end
end