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

ActiveRecord::Schema.define(version: 20150816052939) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blast_emails", force: :cascade do |t|
    t.datetime "sent_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "background_color"
    t.integer  "width"
    t.integer  "height"
    t.text     "items_position"
    t.integer  "member_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "blast_emails", ["member_id"], name: "index_blast_emails_on_member_id"

  create_table "blast_items", force: :cascade do |t|
    t.integer  "image_ratio"
    t.integer  "text_ratio"
    t.integer  "blast_email_id"
    t.integer  "blast_request_id"
    t.integer  "position_index"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "blast_items", ["blast_email_id"], name: "index_blast_items_on_blast_email_id"
  add_index "blast_items", ["blast_request_id"], name: "index_blast_items_on_blast_request_id"

  create_table "blast_requests", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "text"
    t.integer  "status",             default: 0
    t.integer  "member_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "blast_requests", ["member_id"], name: "index_blast_requests_on_member_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "feedbacks", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.integer  "status",     default: 0
    t.integer  "member_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "item_requests", ["item_id"], name: "index_item_requests_on_item_id"
  add_index "item_requests", ["member_id"], name: "index_item_requests_on_member_id"
  add_index "item_requests", ["user_id"], name: "index_item_requests_on_user_id"

  create_table "item_transactions", force: :cascade do |t|
    t.integer  "status",                   default: 0
    t.datetime "pending_sent_at"
    t.datetime "pending_expire_at"
    t.datetime "transaction_began_at"
    t.datetime "transaction_end_at"
    t.datetime "transaction_completed_at"
    t.string   "token",                                null: false
    t.integer  "item_request_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "qrcode_file_name"
    t.string   "qrcode_content_type"
    t.integer  "qrcode_file_size"
    t.datetime "qrcode_updated_at"
  end

  add_index "item_transactions", ["item_request_id"], name: "index_item_transactions_on_item_request_id"
  add_index "item_transactions", ["token"], name: "index_item_transactions_on_token"

  create_table "item_types", force: :cascade do |t|
    t.string   "name",               null: false
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.string   "label"
    t.integer  "status",             default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "item_type_id"
    t.integer  "state",              default: 0
  end

  add_index "items", ["item_type_id"], name: "index_items_on_item_type_id"

  create_table "locker_allocations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "locker_id"
    t.integer  "locker_round_id"
    t.integer  "status",          default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "locker_allocations", ["locker_id"], name: "index_locker_allocations_on_locker_id"
  add_index "locker_allocations", ["locker_round_id"], name: "index_locker_allocations_on_locker_round_id"
  add_index "locker_allocations", ["user_id"], name: "index_locker_allocations_on_user_id"

  create_table "locker_ballots", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "locker_round_id"
    t.string   "location"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "locker_ballots", ["locker_round_id"], name: "index_locker_ballots_on_locker_round_id"
  add_index "locker_ballots", ["user_id"], name: "index_locker_ballots_on_user_id"

  create_table "locker_rounds", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.string   "acad_year"
    t.string   "label"
    t.integer  "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lockers", force: :cascade do |t|
    t.integer  "location",   default: 0
    t.string   "number"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "email",               default: "",              null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,               null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "role_id"
    t.string   "provider",            default: "google_oauth2", null: false
    t.string   "uid",                 default: "",              null: false
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true
  add_index "members", ["role_id"], name: "index_members_on_role_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",            default: "", null: false
    t.string   "uid",                 default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "faculty"
    t.string   "email"
  end
end
