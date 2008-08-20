class AddPhysicalIdToClassified < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :physical_id, :integer
  end

  def self.down
  end
end
