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

ActiveRecord::Schema.define(version: 20140916000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "news", force: true do |t|
    t.string   "title",                        null: false
    t.string   "slug",                         null: false
    t.datetime "published_at",                 null: false
    t.string   "preview"
    t.text     "intro"
    t.text     "body"
    t.text     "seodata"
    t.boolean  "hided",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["hided"], name: "index_news_on_hided", using: :btree
  add_index "news", ["published_at"], name: "index_news_on_published_at", using: :btree
  add_index "news", ["slug"], name: "index_news_on_slug", unique: true, using: :btree

  create_table "settings", force: true do |t|
    t.string   "ident",                      null: false
    t.string   "name"
    t.text     "descr"
    t.integer  "vtype"
    t.text     "val"
    t.string   "group"
    t.boolean  "often"
    t.boolean  "hidden",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["hidden"], name: "index_settings_on_hidden", using: :btree
  add_index "settings", ["ident"], name: "index_settings_on_ident", using: :btree
  add_index "settings", ["often"], name: "index_settings_on_often", using: :btree

  create_table "static_files", force: true do |t|
    t.integer  "holder_id"
    t.string   "holder_type"
    t.string   "file",        null: false
    t.string   "filetype"
    t.float    "filesize"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_files", ["holder_id", "holder_type"], name: "index_static_files_on_holder_id_and_holder_type", using: :btree

end
