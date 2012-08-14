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

ActiveRecord::Schema.define(:version => 20120813194847) do

  create_table "output_valves", :force => true do |t|
    t.string   "type"
    t.integer  "port_index"
    t.integer  "sprinkler_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "output_valves", ["sprinkler_id"], :name => "index_output_valves_on_sprinkler_id"

  create_table "sensor_readings", :force => true do |t|
    t.integer  "sensor_id"
    t.integer  "sensor_value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "read_time"
  end

  add_index "sensor_readings", ["sensor_id"], :name => "index_sensor_readings_on_sensor_id"

  create_table "sensors", :force => true do |t|
    t.string   "identifier"
    t.integer  "port_index"
    t.integer  "sprinkler_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "sensors", ["sprinkler_id"], :name => "index_sensors_on_sprinkler_id"

  create_table "sprinkler_plans", :force => true do |t|
    t.integer  "sprinkler_id"
    t.text     "schedule"
    t.datetime "start_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sprinklers", :force => true do |t|
    t.string   "identifier"
    t.string   "machine_version"
    t.string   "mac_address"
    t.integer  "refresh_rate_seconds"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "sprinklers", ["mac_address"], :name => "index_sprinklers_on_mac_address"

  create_table "sprinklers_users", :force => true do |t|
    t.integer "sprinkler_id"
    t.integer "user_id"
  end

  add_index "sprinklers_users", ["sprinkler_id", "user_id"], :name => "index_sprinklers_users_on_sprinkler_id_and_user_id", :unique => true
  add_index "sprinklers_users", ["sprinkler_id"], :name => "index_sprinklers_users_on_sprinkler_id"
  add_index "sprinklers_users", ["user_id"], :name => "index_sprinklers_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "valves", :force => true do |t|
    t.string   "identifier"
    t.integer  "port_index"
    t.integer  "sprinkler_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "valves", ["sprinkler_id"], :name => "index_valves_on_sprinkler_id"

end
