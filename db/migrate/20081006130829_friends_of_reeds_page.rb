class FriendsOfReedsPage < ActiveRecord::Migration
  def self.up
    Page.create!(:title => "Friends of Reeds", :text => "No text")
  end

  def self.down
  end
end
