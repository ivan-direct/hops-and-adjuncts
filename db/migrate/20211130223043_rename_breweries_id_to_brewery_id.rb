class RenameBreweriesIdToBreweryId < ActiveRecord::Migration[6.1]
  def change
    rename_column :beers, :breweries_id, :brewery_id
  end
end
