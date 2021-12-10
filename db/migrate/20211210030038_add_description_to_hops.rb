class AddDescriptionToHops < ActiveRecord::Migration[6.1]
  def change
    add_column :hops, :description, :text
  end
end
