class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.integer :id
      t.string :dep_airport_id
      t.string :arr_airport_id
      t.integer :aircrafttype_id
      t.integer :distance_miles

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
