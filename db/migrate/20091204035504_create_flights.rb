class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flights do |t|
      t.integer :id
      t.integer :plane_id
      t.integer :route_id
      t.datetime :boarding_started
      t.integer :boarding_scheduled_duration
      t.integer :boarding_delay
      t.datetime :taxi_started
      t.integer :taxi_scheduled_duration
      t.integer :taxi_delay
      t.datetime :inflight_started
      t.integer :inflight_scheduled_duration
      t.integer :inflight_delay
      t.datetime :maintenance_started
      t.integer :maintenance_scheduled_duration
      t.integer :maintenance_delay

      t.timestamps
    end
  end

  def self.down
    drop_table :flights
  end
end
