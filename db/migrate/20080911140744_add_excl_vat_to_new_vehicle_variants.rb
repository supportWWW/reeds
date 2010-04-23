class AddExclVatToNewVehicleVariants < ActiveRecord::Migration
  def self.up
    add_column :new_vehicle_variants, :excl_in_cents, :integer
    add_column :new_vehicle_variants, :vat_in_cents, :integer
  end

  def self.down
  end
end
