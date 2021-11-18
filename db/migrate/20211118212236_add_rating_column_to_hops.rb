class AddRatingColumnToHops < ActiveRecord::Migration[6.1]
  def change
    add_column :hops, :rating, :float
  end
end
