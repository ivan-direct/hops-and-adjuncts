class CreateJoinTableAdjunctsBeers < ActiveRecord::Migration[6.1]
  def change
    create_join_table :adjuncts, :beers do |t|
      t.index [:adjunct_id, :beer_id]
      t.index [:beer_id, :adjunct_id]
    end
  end
end
