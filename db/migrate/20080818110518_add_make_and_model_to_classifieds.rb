class AddMakeAndModelToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :make_id, :integer
    add_column :classifieds, :model_id, :integer
  end

  def self.down
  end
end
