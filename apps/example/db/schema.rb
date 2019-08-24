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

ActiveRecord::Schema.define(version: 2019_08_05_125054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "meeting_rooms", force: :cascade do |t|
    t.text "meeting_room_nm", default: "", null: false
    t.text "memo_content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_users", force: :cascade do |t|
    t.bigint "reservation_id", default: 0, null: false
    t.bigint "user_id", default: 0, null: false
    t.boolean "attendance_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.text "title", default: "", null: false
    t.bigint "user_id", default: 0, null: false
    t.bigint "meeting_room_id", default: 0, null: false
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.text "memo_content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "user_cd", default: "", null: false
    t.text "user_nm", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_cd"], name: "index_users_on_user_cd", unique: true
  end

end
