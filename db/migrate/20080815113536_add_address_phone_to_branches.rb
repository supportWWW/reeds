class AddAddressPhoneToBranches < ActiveRecord::Migration
  def self.up
    add_column :branches, :address, :string
    add_column :branches, :phone, :string
    add_column :branches, :fax, :string
  end

  def self.down
  end
end
