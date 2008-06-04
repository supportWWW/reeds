class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    
    add_column :news_articles, :category_id, :integer, :default => nil
    
  end

  def self.down
    drop_table :categories
  end
end
