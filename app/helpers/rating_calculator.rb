module RatingCalculator
  def calc_add_to_average(restaurant, rating)
    calc_average_after_update(restaurant,0, rating, (restaurant.num_of_reviews + 1))
  end

  def calc_sub_from_average(restaurant, rating)
    reviews = restaurant.num_of_reviews - 1
    num_of_reviews = reviews > 0 ? reviews : 1
    calc_average_after_update(restaurant, rating, 0, num_of_reviews)
  end

  def calc_average_after_update(restaurant, prev_rating, rating, new_num_of_reviews = nil)
    sum = restaurant.rating * restaurant.num_of_reviews - prev_rating + rating

    sum / new_num_of_reviews || restaurant.num_of_reviews
  end
end