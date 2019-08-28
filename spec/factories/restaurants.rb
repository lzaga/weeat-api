FactoryBot.define do
  factory :restaurant do
    name              { Faker::Name.name }
    cuisine           { %w(Breakfast Asian Salads Sushi Cafe Hamburger Hummus Vegetarian Mexican Indian Bistro Italian).sample }
    rating            { 0 }
    ten_bis           { true }
    address           { Faker::Address.full_address }
    max_delivery_time { Faker::Number.between(from: 1, to: 120) }
    num_of_reviews    { 0 }

    trait :with_review do
      after(:create) do |restaurant|
        create(:review, restaurant_id: restaurant.id)
        restaurant.update_attributes :num_of_reviews => 1, :rating => 1
      end
    end
  end
end