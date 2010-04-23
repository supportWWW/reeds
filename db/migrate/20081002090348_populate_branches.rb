class PopulateBranches < ActiveRecord::Migration
  def self.up
    Salesperson.delete_all
    Branch.delete_all
    
    Branch.create!(:name => "Tygervalley", :address => "275 Durban Road\r\nTygervalley", :phone => "(021) 910 7660", :fax => "(021) 910 7676", :stock_code_prefix => "1", :cyberstock_prefix => "RCT")
    Branch.create!(:name => "Cape Town", :address => "Corner of Oswald Pirow and Jack Craig Street\r\nPO Box 3550\r\nCape Town\r\n8000", :phone => "(021) 443 5100", :fax => "(021) 443 5290", :stock_code_prefix => "3", :cyberstock_prefix => "RCC")
    Branch.create!(:name => "N1 City", :address => "Corner of Giel Basson and Nathan Mallach Rd\r\nN1 City\r\nGoodwood", :phone => "(021) 596 2600", :fax => "(021) 596 2798", :stock_code_prefix => "4", :cyberstock_prefix => "RCN")
    Branch.create!(:name => "Isuzu Truck Centre", :address => "Corner of Vanguard and Viking Rds in Epping\r\nEntrance - Agric Rd\r\nWP Park\r\nP O Box 245\r\nEppindust\r\n7475", :phone => "(021) 507 6900", :fax => "(021) 507 6980/1", :stock_code_prefix => "7", :cyberstock_prefix => "RCI")
  end

  def self.down
  end
end
