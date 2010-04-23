class CreateNewsArticles < ActiveRecord::Migration
  def self.up
    create_table :news_articles do |t|
      t.string :title
      t.string :author
      t.string :source_url
      t.string :title_permalink
      t.text :text
      t.text :rendered_text
      t.datetime :publish_at

      t.timestamps
    end
    
    add_index :news_articles, :title_permalink, :unique => true
    
  end

  def self.down
    drop_table :news_articles
  end
end
