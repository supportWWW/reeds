class CreateNewVehicles < ActiveRecord::Migration
  def self.up
    create_table :new_vehicles do |t|
      t.integer :model_range_id
      t.text :description
      t.integer :year
      t.boolean :enabled, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :new_vehicles
  end
end
