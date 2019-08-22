class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :restaurant_id, null:false
      t.string :reviewer
      t.text :review
      t.integer :rating, default: 0

      t.timestamps
    end

    add_index :reviews, :restaurant_id
    add_column :restaurants, :num_of_reviews, :integer
  end
end
