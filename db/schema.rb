# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150402011924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brackets", force: :cascade do |t|
    t.string   "name"
    t.text     "bracket"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open",       default: true
    t.text     "queue",      default: "--- []\n"
    t.boolean  "active",     default: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.integer  "winner_id"
    t.integer  "user1_score"
    t.integer  "user2_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_brackets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bracket_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "games_played"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.string   "secret"
    t.string   "profile_image"
  end

end
