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

ActiveRecord::Schema.define(version: 20160512215435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.float    "percentage"
    t.string   "name"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "unregistered_attendees"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "events_passes", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "pass_id"
  end

  add_index "events_passes", ["event_id"], name: "index_events_passes_on_event_id", using: :btree
  add_index "events_passes", ["pass_id"], name: "index_events_passes_on_pass_id", using: :btree

  create_table "passes", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.text     "description"
    t.string   "colour"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "registrants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "pass_id"
    t.boolean  "signed_in"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "partner"
    t.string   "level"
    t.string   "role"
    t.boolean  "paid",          default: false
    t.integer  "paid_at_event"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
