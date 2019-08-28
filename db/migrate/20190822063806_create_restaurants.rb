class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :cuisine
      t.integer :rating
      t.boolean :ten_bis, default: false
      t.text :address
      t.integer :max_delivery_time

      t.timestamps
    end
  end
end
