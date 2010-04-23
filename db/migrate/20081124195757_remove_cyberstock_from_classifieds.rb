class RemoveCyberstockFromClassifieds < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :cyberstock
  end

  def self.down
  end
end
