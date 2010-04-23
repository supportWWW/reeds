class AddEnableToSpecials < ActiveRecord::Migration
  def self.up
    add_column :specials, :enabled, :boolean, :default => 1
  end

  def self.down
  end
end
