# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180410145425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "detailed_films", force: :cascade do |t|
    t.integer "speech", null: false
    t.bigint "film_title_id", null: false
    t.bigint "format_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_title_id", "speech", "format_id"], name: "index_detailed_films_on_film_title_id_and_speech_and_format_id", unique: true
    t.index ["film_title_id"], name: "index_detailed_films_on_film_title_id"
    t.index ["format_id"], name: "index_detailed_films_on_format_id"
  end

  create_table "film_titles", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "imdb_id", null: false
  end

  create_table "formats", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "formats_screens", force: :cascade do |t|
    t.bigint "format_id", null: false
    t.bigint "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["format_id", "screen_id"], name: "index_formats_screens_on_format_id_and_screen_id", unique: true
    t.index ["format_id"], name: "index_formats_screens_on_format_id"
    t.index ["screen_id"], name: "index_formats_screens_on_screen_id"
  end

  create_table "screenings", force: :cascade do |t|
    t.integer "initial_tickets", null: false
    t.datetime "session_time"
    t.datetime "closing_time"
    t.bigint "detailed_film_id", null: false
    t.bigint "screen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detailed_film_id"], name: "index_screenings_on_detailed_film_id"
    t.index ["screen_id"], name: "index_screenings_on_screen_id"
    t.index ["session_time", "detailed_film_id", "screen_id"], name: "film_screen_time_uniqueness_index", unique: true
  end

  create_table "screens", force: :cascade do |t|
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address", null: false
    t.string "name", null: false
  end

  create_table "sold_tickets", force: :cascade do |t|
    t.datetime "purchase_time"
    t.bigint "screening_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_centavos", default: 0, null: false
    t.index ["screening_id"], name: "index_sold_tickets_on_screening_id"
    t.index ["user_id"], name: "index_sold_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "detailed_films", "film_titles"
  add_foreign_key "detailed_films", "formats"
  add_foreign_key "formats_screens", "formats"
  add_foreign_key "formats_screens", "screens"
  add_foreign_key "screenings", "detailed_films"
  add_foreign_key "screenings", "screens"
  add_foreign_key "sold_tickets", "screenings"
  add_foreign_key "sold_tickets", "users"
end
