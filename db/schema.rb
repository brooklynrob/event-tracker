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

ActiveRecord::Schema.define(version: 20160503145542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_data_sources", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "api_url"
    t.string   "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_title"
    t.string   "event_city"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "datetime"
    t.string   "event_sourceid"
    t.string   "venue_sourceid"
    t.string   "seatgeek_eventurl"
    t.integer  "venue_id"
    t.string   "event_type"
  end

  create_table "us_geos", force: :cascade do |t|
    t.string   "country_code", limit: 2
    t.string   "postal_code",  limit: 20
    t.string   "place_name"
    t.string   "admin_name1"
    t.string   "admin_code1"
    t.string   "admin_name2"
    t.string   "admin_code2"
    t.string   "admin_name3"
    t.string   "admin_code3"
    t.decimal  "latitude",                precision: 10, scale: 6
    t.decimal  "longitude",               precision: 10, scale: 6
    t.integer  "accuracy",     limit: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "venue_types", force: :cascade do |t|
    t.string   "venue_type"
    t.string   "venue_status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "venue_types", ["venue_type"], name: "index_venue_types_on_venue_type", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.decimal  "latitude",                  precision: 10, scale: 6
    t.decimal  "longitude",                 precision: 10, scale: 6
    t.string   "venue_sourceid"
    t.string   "venue_source"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "postal_code",    limit: 20
    t.string   "venue_type"
  end

  add_foreign_key "events", "venues"
end
