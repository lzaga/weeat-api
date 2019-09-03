require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
  end

  context 'validations' do
    it do
      should validate_inclusion_of(:cuisine).in_array(%w(Breakfast Asian Salads Sushi Cafe Hamburger Hummus Vegetarian Mexican Indian Bistro Italian))
    end

    it { should validate_inclusion_of(:rating).in_range(0..3) }
    it { should validate_inclusion_of(:max_delivery_time).in_range(1..120) }
  end
end
