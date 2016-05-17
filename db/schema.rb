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

ActiveRecord::Schema.define(version: 20160517195535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_tag_positions", force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
    t.integer "position"
  end

  add_index "article_tag_positions", ["article_id"], name: "index_article_tag_positions_on_article_id", using: :btree
  add_index "article_tag_positions", ["tag_id"], name: "index_article_tag_positions_on_tag_id", using: :btree

  create_table "article_tags", force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  create_table "articles", force: :cascade do |t|
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "image"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "article_tags_count", default: 0
    t.string   "slug"
  end

  create_table "translated_articles", force: :cascade do |t|
    t.integer  "locale",     default: 0
    t.string   "title"
    t.text     "text"
    t.text     "summary"
    t.string   "slug"
    t.string   "image"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translated_articles", ["article_id"], name: "index_translated_articles_on_article_id", using: :btree
  add_index "translated_articles", ["locale"], name: "index_translated_articles_on_locale", using: :btree
  add_index "translated_articles", ["slug"], name: "index_translated_articles_on_slug", using: :btree

  create_table "user_sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], name: "index_user_sessions_on_session_id", using: :btree
  add_index "user_sessions", ["updated_at"], name: "index_user_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.string   "login",                            null: false
    t.string   "crypted_password",                 null: false
    t.string   "password_salt",                    null: false
    t.string   "email",                            null: false
    t.string   "persistence_token",                null: false
    t.string   "single_access_token",              null: false
    t.string   "perishable_token",                 null: false
    t.integer  "login_count",         default: 0,  null: false
    t.integer  "failed_login_count",  default: 0,  null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_foreign_key "article_tag_positions", "articles"
  add_foreign_key "article_tag_positions", "tags"
  add_foreign_key "translated_articles", "articles"
end
