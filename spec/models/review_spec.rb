require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'associations' do
    it { should belong_to(:restaurant) }
  end

  describe '#remove_review_from_restaurant' do
    before(:each) do
      @restaurant = FactoryBot.create(:restaurant, :with_review)
      @review = @restaurant.reviews[0]
    end

    it "triggers remove_review_from_restaurant on destroy" do
      expect(@review).to receive(:remove_review_from_restaurant)
      @review.destroy
    end

    it "changes restaurant number of reviews and rating" do
      new_num_of_reviews = (@restaurant.num_of_reviews - 1 == 0) ? 1 : @restaurant.num_of_reviews - 1
      expected_num_of_reviews = @restaurant.num_of_reviews - 1
      expected_rating = (@restaurant.rating * @restaurant.num_of_reviews - @review.rating ) / new_num_of_reviews

      @review.destroy

      @restaurant.reload
      expect(@restaurant.rating).to eq(expected_rating)
      expect(@restaurant.num_of_reviews).to eq(expected_num_of_reviews)
    end
  end

  describe '#update_average_rating_on_restaurant' do
    before(:each) do
      @restaurant = FactoryBot.create(:restaurant, :with_review)
      @review = @restaurant.reviews[0]
    end

    it "changes the restaurant rating after update review's rating" do
      expected_rating = (@restaurant.rating * @restaurant.num_of_reviews - @review.rating + 3) / @restaurant.num_of_reviews
      @review.update_average_rating_on_restaurant(@review.rating, 3)

      @restaurant.reload
      expect(@restaurant.rating).to eq(expected_rating)
    end
  end
end
