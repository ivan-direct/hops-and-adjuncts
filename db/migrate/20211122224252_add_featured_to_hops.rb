class AddFeaturedToHops < ActiveRecord::Migration[6.1]
  def change
    add_column :hops, :featured, :boolean, default: false
    remove_column :hops, :form
  end
end
