class AddAverageRatingToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :average_rating, :float
  end
end
