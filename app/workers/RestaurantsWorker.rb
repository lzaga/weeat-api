class RestaurantsWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.tagged('Sidekiq', self.class.name) do
      Rails.logger.debug('Start of perform')
      work
      Rails.logger.debug('End of perform')
    end
  rescue => e
    Rails.logger.error(e)
  end

  def work
    rake :fetch_restaurants_from_zomato
  end
end