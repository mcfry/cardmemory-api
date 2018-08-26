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

ActiveRecord::Schema.define(version: 20180814075832) do

  create_table "best_times", force: :cascade do |t|
    t.integer "user_id"
    t.integer "seconds"
    t.integer "mistakes"
    t.integer "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_best_times_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "suit"
    t.integer "card_number"
    t.string "image_url"
    t.string "name"
    t.string "action1"
    t.string "action2"
    t.index ["deck_id"], name: "index_cards_on_deck_id"
  end

  create_table "deck_infos", force: :cascade do |t|
    t.string "deck_type", null: false
    t.string "red"
    t.string "black"
    t.string "hearts"
    t.string "diamonds"
    t.string "clubs"
    t.string "spades"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.integer "deck_info_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_info_id"], name: "index_decks_on_deck_info_id"
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
