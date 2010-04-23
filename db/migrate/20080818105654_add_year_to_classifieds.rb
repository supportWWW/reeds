class AddYearToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :year, :integer
  end

  def self.down
  end
end
