class EditClassifiedToIncludeStatus < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :status, :string , :default => "A"
  end

  def self.down
    remove_column :classifieds, :status
  end
end
