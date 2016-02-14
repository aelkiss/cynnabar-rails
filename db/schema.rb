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

ActiveRecord::Schema.define(version: 20160112014319) do

  create_table "awardings", force: :cascade do |t|
    t.integer  "award_id",     limit: 4
    t.integer  "recipient_id", limit: 4
    t.date     "received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",     limit: 4
    t.string   "award_name",   limit: 255
  end

  add_index "awardings", ["award_id"], name: "index_awardings_on_award_id", using: :btree
  add_index "awardings", ["group_id"], name: "index_awardings_on_group_id", using: :btree
  add_index "awardings", ["recipient_id"], name: "index_awardings_on_recipient_id", using: :btree

  create_table "awards", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 16777215
    t.integer  "precedence",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",    limit: 4
    t.boolean  "other_award"
  end

  add_index "awards", ["group_id"], name: "index_awards_on_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "image",      limit: 255
    t.integer  "page_id",    limit: 4
    t.integer  "officer_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "offices", ["officer_id"], name: "index_offices_on_officer_id", using: :btree
  add_index "offices", ["page_id"], name: "index_offices_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.text     "body",             limit: 4294967295
    t.string   "title",            limit: 255
    t.string   "slug",             limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id",          limit: 4
    t.string   "calendar",         limit: 255
    t.string   "calendar_title",   limit: 255
    t.boolean  "calendar_details"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  add_index "pages", ["user_id"], name: "index_pages_on_user_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.string   "sca_name",          limit: 255
    t.string   "mundane_name",      limit: 255
    t.boolean  "is_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "also_known_as",     limit: 255
    t.string   "formerly_known_as", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "role",                   limit: 4
    t.string   "name",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "offices", "pages"
  add_foreign_key "offices", "users", column: "officer_id"
  add_foreign_key "pages", "users"
end
