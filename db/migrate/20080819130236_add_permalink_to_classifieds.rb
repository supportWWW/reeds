class AddPermalinkToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :permalink, :string
  end

  def self.down
  end
end
