class AddPermalinkToNewVehcile < ActiveRecord::Migration
  def self.up
    add_column :new_vehicles, :permalink, :string
  end

  def self.down
  end
end
