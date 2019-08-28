module RatingCalculator
  def calc_add_to_average(restaurant, rating)
    calc_average_after_update(restaurant,0, rating, (restaurant.num_of_reviews + 1))
  end

  def calc_sub_from_average(restaurant, rating)
    num_of_reviews = (restaurant.num_of_reviews - 1) != 0 ? restaurant.num_of_reviews - 1 : 1
    calc_average_after_update(restaurant, rating, 0, num_of_reviews)
  end

  def calc_average_after_update(restaurant, rating_was, rating, new_num_of_reviews = nil)
    sum = restaurant.rating * restaurant.num_of_reviews - rating_was + rating

    sum / new_num_of_reviews || restaurant.num_of_reviews
  end
end