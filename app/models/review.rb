require_relative '../helpers/rating_calculator'

class Review < ApplicationRecord
  include RatingCalculator

  belongs_to :restaurant
  after_create :attach_review_to_restaurant
  after_destroy :remove_review_from_restaurant
  after_update -> { update_average_rating_on_restaurant(rating_was, rating) }

  def attach_review_to_restaurant
    restaurant.rating = calc_add_to_average(restaurant, rating)
    restaurant.num_of_reviews += 1

    restaurant.save
  end

  def remove_review_from_restaurant
    restaurant.rating = calc_sub_from_average(restaurant, rating)
    restaurant.num_of_reviews -= 1

    restaurant.save
  end

  def update_average_rating_on_restaurant(rating_was, rating)
    if rating_changed?
      restaurant.rating = calc_average_after_update(restaurant, rating_was, rating)

      restaurant.save
    end
  end
end
