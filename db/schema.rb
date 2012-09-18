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

ActiveRecord::Schema.define(:version => 20120914144112) do

  create_table "alarms", :force => true do |t|
    t.integer  "sensor_id"
    t.string   "alarm_title"
    t.float    "alarm_value"
    t.string   "condition_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "alarms", ["sensor_id"], :name => "index_alarms_on_sensor_id"

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
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "read_time"
    t.decimal  "sensor_value"
  end

  add_index "sensor_readings", ["sensor_id"], :name => "index_sensor_readings_on_sensor_id"

# Could not dump table "sensors" because of following StandardError
#   Unknown type 'sensor' for column 'sensor_type'

  create_table "sprinkler_plans", :force => true do |t|
    t.integer  "sprinkler_id"
    t.text     "schedule"
    t.datetime "start_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "title"
    t.datetime "end_date"
    t.string   "plan_type"
  end

  create_table "sprinkler_plans_valves", :force => true do |t|
    t.integer  "sprinkler_plan_id"
    t.integer  "valf_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "sprinkler_plans_valves", ["sprinkler_plan_id"], :name => "index_sprinkler_plans_valves_on_sprinkler_plan_id"

  create_table "sprinklers", :force => true do |t|
    t.string   "identifier"
    t.string   "machine_version"
    t.string   "mac_address"
    t.integer  "refresh_rate_seconds"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.string   "main_valve_timing",    :default => "simultaneous"
    t.time     "main_valve_delay",     :default => '2000-01-01 00:00:00'
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

  create_table "valf_plans", :force => true do |t|
    t.integer  "sprinkler_plan_id"
    t.integer  "valf_id"
    t.decimal  "amount"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "valf_plans", ["sprinkler_plan_id", "valf_id"], :name => "index_valf_plans_on_sprinkler_plan_id_and_valf_id", :unique => true
  add_index "valf_plans", ["sprinkler_plan_id"], :name => "index_valf_plans_on_sprinkler_plan_id"

  create_table "valves", :force => true do |t|
    t.string   "identifier"
    t.integer  "port_index"
    t.integer  "sprinkler_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "irrigation_mode"
    t.string   "valf_type"
  end

  add_index "valves", ["sprinkler_id"], :name => "index_valves_on_sprinkler_id"

end
