class DenormalizeNewVehicleVariantsForSearch < ActiveRecord::Migration
  def self.up
    add_column :new_vehicle_variants, :make_id, :integer
    add_column :new_vehicle_variants, :model_range_id, :integer
  end

  def self.down
  end
end
