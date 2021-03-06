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

ActiveRecord::Schema.define(version: 2021_12_10_153244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjuncts", force: :cascade do |t|
    t.string "name"
    t.float "rating"
    t.integer "ranking"
    t.integer "previous_ranking"
    t.boolean "featured"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_adjuncts_on_name", unique: true
  end

  create_table "adjuncts_beers", id: false, force: :cascade do |t|
    t.bigint "adjunct_id", null: false
    t.bigint "beer_id", null: false
    t.index ["adjunct_id", "beer_id"], name: "index_adjuncts_beers_on_adjunct_id_and_beer_id"
    t.index ["beer_id", "adjunct_id"], name: "index_adjuncts_beers_on_beer_id_and_adjunct_id"
  end

  create_table "beers", force: :cascade do |t|
    t.string "name"
    t.float "rating"
    t.integer "checkins"
    t.string "style"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "brewery_id"
    t.integer "external_id"
    t.index ["brewery_id"], name: "index_beers_on_brewery_id"
    t.index ["name"], name: "index_beers_on_name", unique: true
  end

  create_table "beers_hops", id: false, force: :cascade do |t|
    t.bigint "hop_id", null: false
    t.bigint "beer_id", null: false
    t.index ["beer_id", "hop_id"], name: "index_beers_hops_on_beer_id_and_hop_id"
    t.index ["hop_id", "beer_id"], name: "index_beers_hops_on_hop_id_and_beer_id"
  end

  create_table "breweries", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "external_code"
    t.boolean "code_invalid", default: false
    t.index ["name"], name: "index_breweries_on_name", unique: true
  end

  create_table "hops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "rating"
    t.integer "ranking"
    t.boolean "featured", default: false
    t.integer "previous_ranking"
    t.text "description"
    t.index ["name"], name: "index_hops_on_name", unique: true
  end

end
