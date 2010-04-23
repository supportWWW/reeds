require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_articles/index.html.erb" do
  include NewsArticlesHelper
  
  before(:each) do
    @category = Category.new( :name => 'test' )
    news_article_98 = mock_model(NewsArticle)
    news_article_98.should_receive(:title).and_return("MyString")
    news_article_98.should_receive(:publish_at).and_return(Time.now)
    news_article_98.stub!(:image).and_return(mock_model(Image, :public_filename => ""))
    news_article_98.should_receive(:text).and_return("")
    
    news_article_99 = mock_model(NewsArticle)
    news_article_99.should_receive(:title).and_return("MyString")
    news_article_99.should_receive(:publish_at).and_return(Time.now)
    news_article_99.stub!(:image).and_return(mock_model(Image, :public_filename => ""))
    news_article_99.should_receive(:text).and_return("")
    
    assigns[:news_articles] = [news_article_98, news_article_99]
    assigns[:news_articles].stub!( :total_pages ).and_return( 1 )
  end

  it "should render list of news_articles" do
    render "/news_articles/index.html.erb"
  end
end

