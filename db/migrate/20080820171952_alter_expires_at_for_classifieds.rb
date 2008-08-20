class AlterExpiresAtForClassifieds < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :expires_at
    add_column :classifieds, :expires_on, :date
  end

  def self.down
  end
end
