class Review < ApplicationRecord
  belongs_to :restaurant
  after_create :attach_review_to_restaurant
  after_destroy :remove_review_from_restaurant

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

  def update_average_rating_on_restaurant(prev_rating, new_rating)
    restaurant = Restaurant.find(restaurant_id)
    restaurant.rating = calc_average_after_update(prev_rating, new_rating)

    restaurant.save
  end

  private

  def calc_average_add(restaurant)
    sum = restaurant.rating * restaurant.num_of_reviews + rating

    sum / (restaurant.num_of_reviews + 1)
  end

  def calc_average_sub(restaurant)
    sum = restaurant.rating * restaurant.num_of_reviews - rating
    num_of_reviews = (restaurant.num_of_reviews - 1) != 0 ? restaurant.num_of_reviews - 1 : 1

    sum / num_of_reviews
  end

  def calc_average_after_update(prev_rating, new_rating)
    sum = restaurant.rating * restaurant.num_of_reviews - prev_rating + new_rating

    sum / restaurant.num_of_reviews
  end
end
