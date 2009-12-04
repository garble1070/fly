class CreateAircrafttypes < ActiveRecord::Migration
  def self.up
    create_table :aircrafttypes do |t|
      t.integer :id
      t.string :code
      t.string :name
      t.integer :max_pax
      t.integer :range_default
      t.integer :avg_speed_default

      t.timestamps
    end
  end

  def self.down
    drop_table :aircrafttypes
  end
end
