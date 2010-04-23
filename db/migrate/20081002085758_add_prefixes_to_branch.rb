class AddPrefixesToBranch < ActiveRecord::Migration
  def self.up
    add_column :branches, :stock_code_prefix, :string
    add_column :branches, :cyberstock_prefix, :string
  end

  def self.down
  end
end
