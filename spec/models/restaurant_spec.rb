require 'rails_helper'
require_relative '../../app/helpers/cuisines'

RSpec.describe Restaurant, type: :model do
  include Cuisines
  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
  end

  describe 'validations' do
    it do
      should validate_inclusion_of(:cuisine).in_array(Cuisines.all_cuisines)
    end

    it { should validate_inclusion_of(:rating).in_range(0..5) }
    it { should validate_inclusion_of(:max_delivery_time).in_range(1..120) }
  end
end
