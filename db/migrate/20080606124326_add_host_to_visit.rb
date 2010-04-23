class AddHostToVisit < ActiveRecord::Migration
  def self.up
    add_column :visits, :referer_host, :string
  end

  def self.down
    remove_column :visits, :referer_host
  end
end
