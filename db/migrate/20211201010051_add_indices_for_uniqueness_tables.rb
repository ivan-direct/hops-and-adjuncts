class AddIndicesForUniquenessTables < ActiveRecord::Migration[6.1]
  def change
    add_index :breweries, :name, unique: true
    add_index :beers, :name, unique: true
    add_index :hops, :name, unique: true
  end
end
