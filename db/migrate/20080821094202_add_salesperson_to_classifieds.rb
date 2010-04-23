class AddSalespersonToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :salesperson_id, :integer
  end

  def self.down
  end
end
