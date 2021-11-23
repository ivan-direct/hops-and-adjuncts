class AddPreviousRankingToHops < ActiveRecord::Migration[6.1]
  def change
    add_column :hops, :previous_ranking, :integer
  end
end
