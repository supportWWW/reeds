class CreatePromotionBoxes < ActiveRecord::Migration
  def self.up
    create_table :promotion_boxes do |t|
      t.string :title
      t.text :body
      t.boolean :active
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :promotion_boxes
  end
end
