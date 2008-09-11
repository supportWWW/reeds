class AddExclVatToAccessories < ActiveRecord::Migration
  def self.up
    add_column :accessories, :excl_in_cents, :integer
    add_column :accessories, :vat_in_cents, :integer
  end

  def self.down
  end
end
