class CreateAdjuncts < ActiveRecord::Migration[6.1]
  def change
    create_table :adjuncts do |t|
      t.string  :name
      t.float   :rating
      t.integer :ranking
      t.integer :previous_ranking
      t.boolean :featured

      t.timestamps
    end

    add_index :adjuncts, :name, unique: true
  end
end
