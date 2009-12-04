class CreatePlanes < ActiveRecord::Migration
  def self.up
    create_table :planes do |t|
      t.integer :id
      t.string :name
      t.integer :airline_id
      t.integer :aircrafttype_id
      t.integer :avg_pax_load
      t.integer :avg_speed
      t.integer :range
      t.string :starting_airport
      t.integer :starting_pax_count
      t.integer :starting_miles_count
      t.timestamps
    end
  end

  def self.down
    drop_table :planes
  end
end
