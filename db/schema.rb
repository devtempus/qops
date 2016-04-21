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

ActiveRecord::Schema.define(version: 20160421114806) do

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "username",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "token",      limit: 255
    t.string   "secret",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name",  limit: 255
    t.string "short_name", limit: 255
    t.string "pseudonym",  limit: 255
    t.string "date_birth", limit: 255
  end

  add_index "authors", ["first_name"], name: "index_authors_on_first_name", unique: true, using: :btree
  add_index "authors", ["short_name"], name: "index_authors_on_short_name", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "categories_quotations", id: false, force: :cascade do |t|
    t.integer "quotation_id", limit: 4
    t.integer "category_id",  limit: 4
  end

  add_index "categories_quotations", ["category_id"], name: "index_categories_quotations_on_category_id", using: :btree
  add_index "categories_quotations", ["quotation_id"], name: "index_categories_quotations_on_quotation_id", using: :btree

  create_table "quotations", force: :cascade do |t|
    t.integer  "author_id",  limit: 4
    t.string   "text",       limit: 255
    t.text     "full_text",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotations", ["author_id"], name: "index_quotations_on_author_id", using: :btree
  add_index "quotations", ["text"], name: "index_quotations_on_text", unique: true, using: :btree

  create_table "quotations_tags", id: false, force: :cascade do |t|
    t.integer "quotation_id", limit: 4
    t.integer "tag_id",       limit: 4
  end

  add_index "quotations_tags", ["quotation_id"], name: "index_quotations_tags_on_quotation_id", using: :btree
  add_index "quotations_tags", ["tag_id"], name: "index_quotations_tags_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "full_name",              limit: 255, default: ""
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
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

end
