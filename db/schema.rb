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

ActiveRecord::Schema.define(:version => 20130527234001) do

  create_table "auth_providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authorizations", :force => true do |t|
    t.string   "uid",              :null => false
    t.integer  "user_id"
    t.integer  "auth_provider_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "authorizations", ["auth_provider_id"], :name => "index_authorizations_on_auth_provider_id"
  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "blog_hosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "url",          :null => false
    t.string   "external_id"
    t.integer  "blog_host_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "follower_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "follows", ["followable_id", "followable_type", "follower_id"], :name => "follow_unique_index"
  add_index "follows", ["follower_id"], :name => "index_follows_on_follower_id"

  create_table "involvements", :force => true do |t|
    t.integer "user_id"
    t.integer "country_id"
    t.text    "description"
    t.string  "sector"
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "messages", :force => true do |t|
    t.string   "message"
    t.integer  "user_id"
    t.string   "msg_type"
    t.string   "status"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "messages", ["parent_id"], :name => "index_messages_on_parent_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body",         :null => false
    t.datetime "published_at"
    t.integer  "blog_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "posts", ["blog_id"], :name => "index_posts_on_blog_id"

  create_table "profiles", :force => true do |t|
    t.string   "location"
    t.text     "bio"
    t.string   "photo_url"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "status"
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "auth_status",     :default => "incomplete"
    t.string   "phone_number"
  end

end
