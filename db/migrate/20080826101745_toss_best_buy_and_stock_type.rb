class TossBestBuyAndStockType < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :best_buy
    remove_column :classifieds, :stock_type
  end

  def self.down
  end
end
