class AddExternalIdToBeers < ActiveRecord::Migration[6.1]
  def change
    add_column :beers, :external_id, :integer
  end
end
