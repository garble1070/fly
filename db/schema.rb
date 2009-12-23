# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091209053835) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "currency_code", :limit => 3
    t.float    "balance",                    :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aircrafttypes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "avg_pax_load_default"
    t.integer  "avg_pax_load_max"
    t.integer  "avg_speed_knots_default"
    t.integer  "avg_speed_knots_max"
    t.integer  "range_miles_default"
    t.integer  "range_miles_max"
    t.float    "boarding_duration_default", :default => 0, :null => false
    t.float  "cost", :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airlines", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "country_code",                 :limit => 2
    t.float    "satisfaction_rating",                       :default => 0.0, :null => false
    t.string   "home_airport_code_game"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airports", :force => true do |t|
    t.string   "code",                  :limit => 4
    t.string   "iata"
    t.string   "icao"
    t.string   "name"
    t.string   "display_name"
    t.string   "city"
    t.string   "country_code", :limit => 2
    t.float    "lng",  :default => 0.0, :null => false
    t.float    "lat",  :default => 0.0, :null => false
    t.integer  "timezone_id"
    t.string   "dst_code"
    t.integer  "altitude"
    t.float    "taxi_duration_default",     :default => 0, :null => false
    t.integer  "terminal_cost_new",       :default => 0, :null => false
    t.integer  "boarding_gate_cost_new_default",              :default => 0, :null => false
  end

  create_table "countries", :force => true do |t|
    t.string  "code",           :limit => 2
    t.string  "name"
    t.string  "display_name"
    t.string  "iso3",           :limit => 3
  end

  create_table "currencies", :force => true do |t|
    t.string   "code",         :limit => 3
    t.string   "name"
    t.float    "ratio_to_flc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "accepted_at"
  end

  create_table "flights", :force => true do |t|
    t.integer  "plane_id"
    t.string   "dep_airport_code"
    t.string   "arr_airport_code"
    t.datetime "boarding_start_time"
    t.float  "boarding_duration"
    t.float  "taxi_duration"
    t.float  "inflight_duration"
    t.datetime "flight_completed_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terminals", :force => true do |t|
    t.string  "airport_code"
    t.integer  "airline_id"
    t.integer  "boarding_gate_count"
    t.integer  "boarding_gate_cost_new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planes", :force => true do |t|
    t.string   "name"
    t.integer  "airline_id"
    t.integer  "aircrafttype_id"
    t.integer  "avg_pax_load"
    t.integer  "avg_speed_knots"
    t.integer  "range_miles"
    t.string   "starting_airport_code", :limit => 3
    t.integer  "starting_pax_count",                 :default => 0, :null => false
    t.float    "starting_miles_count",               :default => 0.0, :null => false
    t.float    "acquisition_cost",                 :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "home_airport_code_real"
    t.boolean  "admin"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
