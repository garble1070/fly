class CreateTerminals < ActiveRecord::Migration
  def self.up
    create_table :terminals do |t|
      t.integer :airport_id

      t.timestamps
    end
  end

  def self.down
    drop_table :terminals
  end
end
