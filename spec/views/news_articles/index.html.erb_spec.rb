require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_articles/index.html.erb" do
  include NewsArticlesHelper
  
  before(:each) do
    @category = Category.new( :name => 'test' )
    news_article_98 = mock_model(NewsArticle)
    news_article_98.should_receive(:title).and_return("MyString")
    news_article_98.should_receive(:publish_at).and_return(Time.now)
    news_article_98.should_receive( :category ).and_return( @category )
    
    news_article_99 = mock_model(NewsArticle)
    news_article_99.should_receive(:title).and_return("MyString")
    news_article_99.should_receive(:publish_at).and_return(Time.now)
    news_article_99.should_receive( :category ).and_return( @category )
    
    assigns[:news_articles] = [news_article_98, news_article_99]
    assigns[:news_articles].stub!( :total_pages ).and_return( 1 )
  end

  it "should render list of news_articles" do
    render "/news_articles/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "test", 2)
  end
end

