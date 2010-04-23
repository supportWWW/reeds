class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :title
      t.integer :page_id
      t.string :path
      t.integer :parent_id
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
