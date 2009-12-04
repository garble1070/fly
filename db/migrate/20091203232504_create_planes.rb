class CreatePlanes < ActiveRecord::Migration
  def self.up
    create_table :planes do |t|
      t.integer :id
      t.string :name
      t.integer :airline_id
      t.integer :aircrafttype_id
      t.integer :range
      t.integer :avg_speed
      t.string :status
      t.integer :last_airport_id
      t.integer :next_airport_id
      t.integer :pax_current
      t.integer :pax_counter
      t.integer :pax_cycle_counter
      t.integer :miles_counter
      t.integer :miles_cycle_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :planes
  end
end
