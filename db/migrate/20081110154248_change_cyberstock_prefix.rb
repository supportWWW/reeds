class ChangeCyberstockPrefix < ActiveRecord::Migration
  def self.up
    b = Branch.find_by_cyberstock_prefix("RCT")
    b.cyberstock_prefix = "TV"
    b.save

    b = Branch.find_by_cyberstock_prefix("RCC")
    b.cyberstock_prefix = "CT"
    b.save

    b = Branch.find_by_cyberstock_prefix("RCN")
    b.cyberstock_prefix = "N1"
    b.save

    b = Branch.find_by_cyberstock_prefix("RCI")
    b.cyberstock_prefix = "ITC"
    b.save
    
  end

  def self.down
  end
end

