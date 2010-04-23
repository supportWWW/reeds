class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.integer :size
      t.string :filename
      t.string :content_type
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
