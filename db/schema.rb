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

ActiveRecord::Schema.define(version: 20140723003204) do

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weathers", force: true do |t|
    t.string   "weather"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.float    "temp"
    t.float    "precip_amt"
    t.float    "precip_prb"
    t.float    "humidity"
    t.float    "wind_speed"
    t.float    "temp_one"
    t.float    "temp_two"
    t.float    "temp_three"
    t.float    "temp_four"
    t.float    "temp_five"
    t.string   "weekly_summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "daily"
    t.boolean  "weekly"
    t.boolean  "rain"
    t.boolean  "temp_ntf"
    t.float    "rain_one"
    t.float    "rain_four"
    t.float    "rain_seven"
    t.float    "rain_ten"
    t.float    "rain_thirt"
  end

end
