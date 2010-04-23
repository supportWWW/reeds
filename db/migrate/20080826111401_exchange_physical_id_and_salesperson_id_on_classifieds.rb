class ExchangePhysicalIdAndSalespersonIdOnClassifieds < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :physical_id
    remove_column :classifieds, :salesperson_id

    add_column :classifieds, :physical_stock, :string
    add_column :classifieds, :branch_id, :integer
  end

  def self.down
  end
end
