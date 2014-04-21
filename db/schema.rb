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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140406000000) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "content_pages", :force => true do |t|
    t.string   "title"
    t.string   "slug",                             :null => false
    t.string   "ancestry"
    t.boolean  "immortal"
    t.integer  "behavior_type", :default => 0,     :null => false
    t.integer  "rct_page_id"
    t.string   "rct_lnk"
    t.text     "body"
    t.string   "description"
    t.string   "keywords"
    t.integer  "prior",         :default => 10,    :null => false
    t.boolean  "hided",         :default => false, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "content_pages", ["ancestry"], :name => "index_content_pages_on_ancestry"
  add_index "content_pages", ["hided"], :name => "index_content_pages_on_hided"
  add_index "content_pages", ["prior"], :name => "index_content_pages_on_prior"
  add_index "content_pages", ["slug"], :name => "index_content_pages_on_slug"

  create_table "main_nav_items", :force => true do |t|
    t.string   "title"
    t.integer  "url_type",    :default => 0,     :null => false
    t.integer  "url_page_id"
    t.string   "url_text"
    t.integer  "prior",       :default => 10,    :null => false
    t.boolean  "hided",       :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "main_nav_items", ["hided"], :name => "index_main_nav_items_on_hided"
  add_index "main_nav_items", ["prior"], :name => "index_main_nav_items_on_prior"
  add_index "main_nav_items", ["url_page_id"], :name => "index_main_nav_items_on_url_page_id"

  create_table "site_settings", :force => true do |t|
    t.string   "ident",                         :null => false
    t.string   "name"
    t.string   "descr"
    t.integer  "val_type"
    t.string   "set_val"
    t.boolean  "hided",      :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "site_settings", ["hided"], :name => "index_site_settings_on_hided"
  add_index "site_settings", ["ident"], :name => "index_site_settings_on_ident"

  create_table "static_files", :force => true do |t|
    t.string   "file",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
