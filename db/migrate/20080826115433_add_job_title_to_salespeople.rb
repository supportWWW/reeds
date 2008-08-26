class AddJobTitleToSalespeople < ActiveRecord::Migration
  def self.up
    add_column :salespeople, :job_title, :string
  end

  def self.down
  end
end
