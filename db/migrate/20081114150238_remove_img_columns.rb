class RemoveImgColumns < ActiveRecord::Migration
  def self.up
    remove_column :classifieds, :img1_url
    remove_column :classifieds, :img2_url
    remove_column :classifieds, :img3_url
  end

  def self.down
  end
end
