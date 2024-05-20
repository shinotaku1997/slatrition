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

ActiveRecord::Schema[7.1].define(version: 2024_05_20_144233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "sex"
    t.integer "age"
    t.integer "weight"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bodies_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "body_id", null: false
    t.integer "goal_weight"
    t.integer "volume_of_activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_id"], name: "index_goals_on_body_id"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "individual_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bodies", "users"
  add_foreign_key "goals", "bodies"
  add_foreign_key "goals", "users"
end
