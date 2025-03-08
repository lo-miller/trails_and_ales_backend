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

ActiveRecord::Schema.define(version: 2025_03_08_191652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "features", force: :cascade do |t|
    t.string "feature_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "features_hikes", id: false, force: :cascade do |t|
    t.bigint "hike_id", null: false
    t.bigint "feature_id", null: false
  end

  create_table "hikes", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "state", null: false
    t.string "region"
    t.float "length", null: false
    t.string "difficulty", null: false
    t.string "route_type"
    t.float "highest_point"
    t.float "elevation_gain"
    t.string "url", null: false
    t.string "required_pass"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.float "rating"
    t.string "photo_url"
  end

  create_table "saved_hikes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "hike_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "brewery_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
