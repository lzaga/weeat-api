class Restaurant < ApplicationRecord
  @@cuisines = %w(Hamburger Italian Salads Indian Sushi Vegetarian Sandwich Asian Cafe Soup Mexican Bistro Breakfast)

  validates_inclusion_of :rating, :in => 1..3
  validates_inclusion_of :max_delivery_time, :in => 0..120
  validates :cuisine, :inclusion=> { :in => @@cuisines }
end
