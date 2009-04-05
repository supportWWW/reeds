class AddPositionToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :position, :integer
  end

  def self.down
  end
end
