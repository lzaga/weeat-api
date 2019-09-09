desc 'fetch cuisines from Zomato'

task :fetch_cuisines_from_zomato => :environment do
  GET_RESTAURANTS_URL = ENV['ZOMATO_URL'] + '/cuisines'.freeze

  cuisines = fetch_cuisines

  cuisines.each do |cuisine|
    puts cuisine['cuisine']['cuisine_name'] # Just printing it for now...
  end
end

def fetch_cuisines
  conn = Faraday.new

  response = conn.get(GET_RESTAURANTS_URL) do |req|
    req.headers['user-key'] = ENV['ZOMATO_KEY']
    req.params = {
        city_id: ENV['ZOMATO_NY_CODE'],
    }
  end

  JSON.parse(response.body)['cuisines']
end