class AddImgFieldsToClassifieds < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :img_url
    add_column :classifieds, :img1_url, :string
    add_column :classifieds, :img2_url, :string
    add_column :classifieds, :img3_url, :string
  end

  def self.down
  end
end
