class AddStyleToPromotions < ActiveRecord::Migration
  def self.up
    add_column :promotion_boxes, :style, :string
  end

  def self.down
  end
end
