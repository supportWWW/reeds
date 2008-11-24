class AddWebLeadsToSalespeople < ActiveRecord::Migration
  def self.up
    add_column :salespeople, :receive_web_leads, :boolean
  end

  def self.down
  end
end
