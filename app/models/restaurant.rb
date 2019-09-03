require_relative '../../app/helpers/cuisines'

class Restaurant < ApplicationRecord
  include Cuisines
  has_many :reviews, dependent: :destroy

  validates_inclusion_of :cuisine, in: Cuisines.all_cuisines
  validates_inclusion_of :rating, in: 0..5
  validates_inclusion_of :max_delivery_time, in: 1..120
end
