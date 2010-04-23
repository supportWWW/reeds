class AddTypeToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :type, :string
  end

  def self.down
  end
end
