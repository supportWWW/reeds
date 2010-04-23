class AddPermalinkToNewVehcileVariants < ActiveRecord::Migration
  def self.up
    add_column :new_vehicle_variants, :permalink, :string
  end

  def self.down
  end
end
