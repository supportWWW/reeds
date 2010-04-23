class AddNameToImagesAndAttachments < ActiveRecord::Migration
  def self.up
    add_column :images, :name, :string
    add_column :images, :thumbnail, :string
    add_column :attachments, :name, :string
  end

  def self.down
    remove_column :images, :name
    remove_column :images, :thumbnail
    remove_column :attachments, :name
  end
end
