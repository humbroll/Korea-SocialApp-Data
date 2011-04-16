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

ActiveRecord::Schema.define(:version => 20110416012309) do

  create_table "apps", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "appId",       :null => false
    t.string   "author",      :null => false
    t.text     "description", :null => false
    t.string   "category",    :null => false
    t.date     "birthday",    :null => false
    t.string   "platform",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "casein_users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "name"
    t.string   "email"
    t.integer  "access_level",        :default => 0, :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", :force => true do |t|
    t.integer  "rank",          :null => false
    t.string   "orderType",     :null => false
    t.float    "rating",        :null => false
    t.integer  "downloadCount", :null => false
    t.integer  "app_id",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
