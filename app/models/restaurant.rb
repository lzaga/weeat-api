class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  @@cuisine = %w(Breakfast Asian Salads Sushi Cafe Hamburger Hummus Vegetarian Mexican Indian Bistro Italian)

  validates_inclusion_of :cuisine, :in => @@cuisine
  validates_inclusion_of :rating, :in => 0..3
  validates_inclusion_of :max_delivery_time, :in => 1..120
end
