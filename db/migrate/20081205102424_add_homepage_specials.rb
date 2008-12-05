class AddHomepageSpecials < ActiveRecord::Migration
  def self.up
    add_column :specials, :slideshow, :boolean, :default => 0
  end

  def self.down
  end
end
