class AddTypeToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :type, :string
  end

  def self.down
  end
end
