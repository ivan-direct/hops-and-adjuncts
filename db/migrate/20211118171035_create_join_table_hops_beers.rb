class CreateJoinTableHopsBeers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :hops, :beers do |t|
      t.index [:hop_id, :beer_id]
      t.index [:beer_id, :hop_id]
    end
  end
end
