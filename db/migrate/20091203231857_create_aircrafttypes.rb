class CreateAircrafttypes < ActiveRecord::Migration
  def self.up
    create_table :aircrafttypes do |t|
      t.integer :id
      t.string :code
      t.string :name
      t.integer :avg_pax_load_default
      t.integer :avg_pax_load_max
      t.integer :avg_speed_default
      t.integer :avg_speed_max
      t.integer :range_default
      t.integer :range_max

      t.timestamps
    end
  end

  def self.down
    drop_table :aircrafttypes
  end
end
