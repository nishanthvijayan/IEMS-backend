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

ActiveRecord::Schema.define(version: 20160425170059) do

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "guest_users", force: :cascade do |t|
    t.string   "name"
    t.integer  "regular_user_id"
    t.string   "details"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.date     "from_date"
    t.date     "to_date"
  end

  create_table "regular_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.boolean  "manager",         default: false
    t.string   "password_digest"
    t.string   "image_url"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "guest_user_id"
    t.integer  "regular_user_id"
    t.boolean  "guest_transaction", default: false
    t.string   "food_type"
    t.date     "date"
    t.integer  "price"
    t.string   "image"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
