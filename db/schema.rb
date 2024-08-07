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

ActiveRecord::Schema[7.1].define(version: 2024_07_07_065120) do
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

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_bookmarks_on_recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_bookmarks_on_user_id_and_recipe_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
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
    t.integer "calories"
    t.integer "proteins"
    t.integer "carbhydarates"
    t.integer "fats"
    t.integer "salts"
    t.integer "fibers"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "bodies", "users"
  add_foreign_key "bookmarks", "recipes"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "goals", "bodies"
  add_foreign_key "goals", "users"
end
