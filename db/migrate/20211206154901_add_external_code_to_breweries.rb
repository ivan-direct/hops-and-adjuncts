class AddExternalCodeToBreweries < ActiveRecord::Migration[6.1]
  def change
    add_column :breweries, :external_code, :string
  end
end
