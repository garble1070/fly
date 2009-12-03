class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :id
      t.string :name
      t.float :ratio_to_flc

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
