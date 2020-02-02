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

ActiveRecord::Schema.define(version: 20200202173402) do

  create_table "awardings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "award_id"
    t.integer  "recipient_id"
    t.date     "received"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "award_name"
    t.text     "award_text",   limit: 4294967295
    t.index ["award_id"], name: "index_awardings_on_award_id", using: :btree
    t.index ["group_id"], name: "index_awardings_on_group_id", using: :btree
    t.index ["recipient_id"], name: "index_awardings_on_recipient_id", using: :btree
  end

  create_table "awards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.text     "description",           limit: 16777215
    t.integer  "precedence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.boolean  "other_award"
    t.boolean  "society",                                default: false, null: false
    t.string   "heraldry_file_name"
    t.string   "heraldry_content_type"
    t.integer  "heraldry_file_size"
    t.datetime "heraldry_updated_at"
    t.text     "heraldry_blazon",       limit: 16777215
    t.index ["group_id"], name: "index_awards_on_group_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.integer  "page_id"
    t.integer  "officer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["officer_id"], name: "index_offices_on_officer_id", using: :btree
    t.index ["page_id"], name: "index_offices_on_page_id", using: :btree
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text     "body",             limit: 4294967295
    t.string   "title"
    t.string   "slug"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "user_id"
    t.string   "calendar"
    t.string   "calendar_title"
    t.boolean  "calendar_details"
    t.string   "logo"
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_pages_on_user_id", using: :btree
  end

  create_table "recipients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "sca_name"
    t.string   "mundane_name"
    t.boolean  "is_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "also_known_as"
    t.string   "formerly_known_as"
    t.string   "title"
    t.string   "pronouns"
    t.string   "heraldry_file_name"
    t.string   "heraldry_content_type"
    t.integer  "heraldry_file_size"
    t.datetime "heraldry_updated_at"
    t.text     "heraldry_blazon",       limit: 16777215
    t.text     "mundane_bio",           limit: 4294967295
    t.text     "sca_bio",               limit: 4294967295
    t.text     "activities",            limit: 4294967295
    t.text     "food_prefs",            limit: 4294967295
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "name"
    t.boolean  "approved"
    t.integer  "recipient_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["recipient_id"], name: "index_users_on_recipient_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "offices", "pages"
  add_foreign_key "offices", "users", column: "officer_id"
  add_foreign_key "pages", "users"
  add_foreign_key "users", "recipients"
end
