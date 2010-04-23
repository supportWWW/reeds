class UpdatePositionOnMenuItems < ActiveRecord::Migration
  def self.up
    
    MenuItem.find( :all ).each do |m|
      MenuItem.update_all( { :depth => m.calculate_depth }, { :id => m.id })
    end
    
  end

  def self.down
  end
end
