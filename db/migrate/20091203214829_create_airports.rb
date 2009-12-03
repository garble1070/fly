class CreateAirports < ActiveRecord::Migration
  def self.up
    create_table :airports do |t|
      t.string :id
      t.string :name
      t.string :city
      t.integer :country_id
      t.string :longitude
      t.string :latitude
      t.integer :timezone_id

      t.timestamps
    end
  end

  def self.down
    drop_table :airports
  end
end
