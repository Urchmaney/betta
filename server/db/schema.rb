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

ActiveRecord::Schema[7.1].define(version: 2025_01_16_172110) do
  create_table "bet_placements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "bet_id", null: false
    t.integer "amount", null: false
    t.integer "cashback", null: false
    t.boolean "won", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_id"], name: "index_bet_placements_on_bet_id"
    t.index ["user_id"], name: "index_bet_placements_on_user_id"
  end

  create_table "bets", force: :cascade do |t|
    t.string "external_id"
    t.integer "game_id", null: false
    t.string "bet_type", null: false
    t.string "pick", null: false
    t.float "odd", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_bets_on_external_id", unique: true
    t.index ["game_id"], name: "index_bets_on_game_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "event_type", null: false
    t.boolean "for_home"
    t.string "player"
    t.integer "minute", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_events_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "external_id"
    t.string "home_team"
    t.string "away_team"
    t.integer "away_score", default: 0
    t.integer "home_score", default: 0
    t.integer "time_elapsed", limit: 120, default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_games_on_external_id", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "external_id"
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.decimal "balance", default: "150.0"
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
    t.check_constraint "balance >= 0"
  end

  add_foreign_key "bet_placements", "bets"
  add_foreign_key "bet_placements", "users"
  add_foreign_key "bets", "games"
  add_foreign_key "events", "games"
  add_foreign_key "sessions", "users"
end
