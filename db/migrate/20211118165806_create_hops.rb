class CreateHops < ActiveRecord::Migration[6.1]
  def change
    create_table :hops do |t|
      t.string :name
      t.string :form
      t.timestamps
    end
  end
end
