class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  @@cuisine = %w(Breakfast Asian Salads Sushi Cafe Hamburger Hummus Vegetarian Mexican Indian Bistro Italian)
  MAX_RATING = 5
  MAX_DELIVERY_TIME = 120

  validates_inclusion_of :cuisine, in: @@cuisine
  validates_inclusion_of :rating, in: 0..MAX_RATING
  validates_inclusion_of :max_delivery_time, in: 1..MAX_DELIVERY_TIME
end
