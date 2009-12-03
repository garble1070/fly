class CreateAirlines < ActiveRecord::Migration
  def self.up
    create_table :airlines do |t|
      t.string :name
      t.integer :user_id
      t.string :country_id
      t.float :satisfaction_rating

      t.timestamps
    end
  end

  def self.down
    drop_table :airlines
  end
end
