class AddCodeInvalidToBrewery < ActiveRecord::Migration[6.1]
  def change
    add_column :breweries, :code_invalid, :boolean, default: :false
  end
end
