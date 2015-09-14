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

ActiveRecord::Schema.define(version: 20150909132213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "image"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "city_name"
    t.string   "state"
    t.string   "country"
    t.boolean  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "reply"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "current_locations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "online"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
  end

  add_index "current_locations", ["user_id"], name: "index_current_locations_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "device_id"
    t.string   "device_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "event_name"
    t.string   "place"
    t.string   "link"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "event_time"
    t.string   "host_name"
    t.string   "image"
    t.datetime "event_date"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "group_name"
    t.integer  "group_admin"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "interests", force: :cascade do |t|
    t.string   "interest_name"
    t.string   "description"
    t.string   "image"
    t.string   "icon"
    t.boolean  "status"
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "banner"
  end

  add_index "interests", ["category_id"], name: "index_interests_on_category_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "reciever"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "group_id"
    t.boolean  "status",     default: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "message"
    t.string   "notification_type"
    t.boolean  "status"
    t.integer  "reciever"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "points", force: :cascade do |t|
    t.string   "pointable_type"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "points", ["user_id"], name: "index_points_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "user_type"
    t.integer  "admin_user_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.string   "location"
    t.string   "gender"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "dob"
    t.string   "fb_email"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "question"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.boolean  "status"
  end

  add_index "questions", ["interest_id"], name: "index_questions_on_interest_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.string   "rate"
    t.integer  "rater_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reason"
  end

  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "service_points", force: :cascade do |t|
    t.string   "service"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "point",      limit: 8
  end

  create_table "special_messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "status"
  end

  add_index "special_messages", ["interest_id"], name: "index_special_messages_on_interest_id", using: :btree

  create_table "uploded_files", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "user_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "authentication_token"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "online"
    t.string   "current_city"
    t.string   "address"
    t.datetime "last_active_at"
    t.integer  "active_interest"
    t.boolean  "message_notification",        default: true
    t.boolean  "friend_request_notification", default: true
    t.boolean  "new_event_notification",      default: true
    t.boolean  "updates_notification",        default: true
  end

  create_table "users_categories", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
  end

  create_table "users_cities", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "city_id"
  end

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users_interests", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "interest_id"
  end

  add_foreign_key "albums", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "interests", "categories"
  add_foreign_key "invitations", "users"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "points", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "interests"
  add_foreign_key "ratings", "users"
  add_foreign_key "special_messages", "interests"
end
