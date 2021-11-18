class AddRankingColumnToHops < ActiveRecord::Migration[6.1]
  def change
    add_column :hops, :ranking, :integer
  end
end
