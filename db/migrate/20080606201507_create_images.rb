class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :parent_id
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
