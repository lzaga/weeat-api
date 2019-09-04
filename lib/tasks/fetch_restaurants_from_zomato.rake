desc 'fetch restaurants from Zomato'

task :fetch_restaurants_from_zomato => :environment do
  MAX_RESTAURANTS     = 20
  MAX_REVIEWS         = 5
  GET_RESTAURANTS_URL = ENV['ZOMATO_URL'] + '/search'

  restaurants = fetch_restaurants

  restaurants.each do |restaurant_obj|
    restaurant = restaurant_obj["restaurant"]

    save_restaurant_and_reviews(restaurant)
  end
end

def fetch_restaurants
  conn = Faraday.new

  begin
    response = conn.get(GET_RESTAURANTS_URL) do |req|
      req.headers['user-key'] = ENV['ZOMATO_KEY']
      req.params = {
          entity_id: ENV['ZOMATO_NY_CODE'],
          entity_type: ENV['ZOMATO_ENTITY_TYPE'],
          count: MAX_RESTAURANTS
      }
    end
    JSON.parse(response.body)['restaurants']
  rescue => e
    Rails.logger.error e
  end
end

def save_restaurant_and_reviews(restaurant_data)
  begin
    Restaurant.find_or_create_by(name: restaurant_data["name"]) do |new_restaurant|
      if new_restaurant.new_record?
        new_restaurant.cuisine = restaurant_data["cuisines"].split(',')[0]
        new_restaurant.rating = 0
        new_restaurant.ten_bis = restaurant_data["has_online_delivery"] === 0 ? true : false
        new_restaurant.address = "#{restaurant_data["location"]["address"]}, #{restaurant_data["location"]["city"]}, NY, United States"
        new_restaurant.max_delivery_time = 40
        new_restaurant.save!

        new_restaurant.reload
        save_reviews_on_restaurant(new_restaurant, restaurant_data["all_reviews"]["reviews"])
      end
    end
  rescue => e
    Rails.logger.error e
  end
end

def save_reviews_on_restaurant(restaurant, reviews)
    reviews[0..MAX_REVIEWS].each do |review_obj|
      review = review_obj["review"]

      begin
        params = {
            restaurant_id: restaurant.id,
            reviewer: review["user"]["mame"],
            rating: review["rating"],
            review: review["review_text"]
        }

        Review.create(params)
      rescue => e
        Rails.logger.error e
      end
    end
end