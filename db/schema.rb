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

ActiveRecord::Schema.define(:version => 20091203232504) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "currency_id", :limit => 3
    t.float    "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aircrafttypes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "max_pax"
    t.integer  "range_default"
    t.integer  "avg_speed_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airlines", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "country_id",          :default => "",  :null => false
    t.float    "satisfaction_rating", :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airports", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.integer  "country_id"
    t.string   "longitude"
    t.string   "latitude"
    t.integer  "timezone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3",           :limit => 3
    t.integer "numcode"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.float    "ratio_to_flc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "planes", :force => true do |t|
    t.string   "name"
    t.integer  "airline_id"
    t.integer  "aircrafttype_id"
    t.integer  "range"
    t.integer  "avg_speed"
    t.string   "status"
    t.integer  "last_airport_id"
    t.integer  "next_airport_id"
    t.integer  "pax_current"
    t.integer  "pax_counter"
    t.integer  "pax_cycle_counter"
    t.integer  "miles_counter"
    t.integer  "miles_cycle_counter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "routes", :force => true do |t|
    t.string   "dep_airport_id"
    t.string   "arr_airport_id"
    t.integer  "aircrafttype_id", :default => 0, :null => false
    t.integer  "distance_miles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.boolean  "admin"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
