require_relative '../../app/helpers/cuisines'

class Restaurant < ApplicationRecord
  include Cuisines
  has_many :reviews, dependent: :destroy

  MAX_RATING = 5
  MAX_DELIVERY_TIME = 120

  validates_inclusion_of :cuisine, in: Cuisines.all_cuisines
  validates_inclusion_of :rating, in: 0..MAX_RATING
  validates_inclusion_of :max_delivery_time, in: 1..MAX_DELIVERY_TIME
end
