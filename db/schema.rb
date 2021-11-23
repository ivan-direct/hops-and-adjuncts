# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_22_224252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.float "rating"
    t.integer "checkins"
    t.string "style"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "beers_hops", id: false, force: :cascade do |t|
    t.bigint "hop_id", null: false
    t.bigint "beer_id", null: false
    t.index ["beer_id", "hop_id"], name: "index_beers_hops_on_beer_id_and_hop_id"
    t.index ["hop_id", "beer_id"], name: "index_beers_hops_on_hop_id_and_beer_id"
  end

  create_table "hops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "rating"
    t.integer "ranking"
    t.boolean "featured", default: false
  end

end
