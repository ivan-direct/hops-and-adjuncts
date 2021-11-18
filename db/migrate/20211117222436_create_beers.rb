# frozen_string_literal: true

class CreateBeers < ActiveRecord::Migration[6.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.float :rating
      t.integer :checkins
      t.string :style
      t.timestamps
    end
  end
end
