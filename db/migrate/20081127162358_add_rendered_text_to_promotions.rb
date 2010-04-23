class AddRenderedTextToPromotions < ActiveRecord::Migration
  def self.up
    add_column :promotion_boxes, :rendered_body, :text
  end

  def self.down
  end
end
