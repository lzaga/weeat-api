class Review < ApplicationRecord
  belongs_to :restaurant
  after_save :attach_review_to_restaurant
  after_destroy :remove_review_from_restaurant
  after_update :update_average_rating_on_restaurant

  def attach_review_to_restaurant
    restaurant = Restaurant.find(restaurant_id)
    restaurant.rating = calc_average_add(restaurant)
    restaurant.num_of_reviews += 1

    restaurant.save
  end

  def remove_review_from_restaurant
    restaurant = Restaurant.find(restaurant_id)
    restaurant.rating = calc_average_sub(restaurant)
    restaurant.num_of_reviews -= 1

    restaurant.save
  end

  private

  def calc_average_add(restaurant)
    sum = restaurant.rating * restaurant.num_of_reviews + rating

    sum / (restaurant.num_of_reviews + 1)
  end

  def calc_average_sub(restaurant)
    sum = restaurant.rating * restaurant.num_of_reviews - rating

    sum / (restaurant.num_of_reviews - 1)
  end
end
