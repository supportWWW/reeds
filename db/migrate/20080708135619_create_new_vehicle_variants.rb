class CreateNewVehicleVariants < ActiveRecord::Migration
  def self.up
    create_table :new_vehicle_variants do |t|
      t.string :name
      t.text :description
      t.integer :price_in_cents
      t.string :model_reference
      t.integer :new_vehicle_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :new_vehicle_variants
  end
end
