class AddIndexes < ActiveRecord::Migration
  def self.up    
    add_index :news_articles, :category_id
    
    add_index :pages, :title_permalink, :unique => true
    
    add_index :menu_items, :page_id
    add_index :menu_items, :parent_id
    
    add_index :visits, :referral_id
    
    add_index :attachments, :owner_id
    add_index :attachments, :owner_type

    add_index :images, :owner_id
    add_index :images, :owner_type
    add_index :images, :parent_id
    
    add_index :assignments, :salesperson_id
    add_index :assignments, :branch_id    
  end

  def self.down
  end
end
