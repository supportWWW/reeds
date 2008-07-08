class CreateAccessories < ActiveRecord::Migration
  def self.up
    create_table :accessories do |t|
      t.string :name
      t.text :description
      t.integer :price_in_cents
      t.integer :new_vehicle_id, :null => false
      t.string :model_reference
      t.timestamps
    end
  end

  def self.down
    drop_table :accessories
  end
end
