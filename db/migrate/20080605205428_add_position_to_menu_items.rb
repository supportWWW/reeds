class AddPositionToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :depth, :integer
  end

  def self.down
    remove_column :menu_items, :depth
  end
end
