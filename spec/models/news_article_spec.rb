require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsArticle do
  before(:each) do
    @news_article = NewsArticle.new( :title => 'test', :text => 'test', :publish_at => Time.now )
  end

  after :each do
    NewsArticle.delete_all
  end
  
  it "should be valid" do
    @news_article.should be_valid
  end
  
  it 'Should have an error on the title' do
    @news_article.title = nil
    @news_article.should have(1).error_on( :title )
  end

  it 'Should have an error on the text' do
    @news_article.text = nil
    @news_article.should have(1).error_on( :text )
  end
  
  it 'Should have another error on title' do
    @news_article.save!
    @other_article = NewsArticle.new( :title => @news_article.title )
    @other_article.should have(1).error_on( :title )
  end
  
end
