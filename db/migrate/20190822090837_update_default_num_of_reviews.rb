class UpdateDefaultNumOfReviews < ActiveRecord::Migration[6.0]
  change_column_default :restaurants, :num_of_reviews, 0
end
