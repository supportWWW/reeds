class RemoveYearFromClassifieds < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :year
  end

  def self.down
  end
end
