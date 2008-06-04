require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_articles/index.html.erb" do
  include NewsArticlesHelper
  
  before(:each) do
    news_article_98 = mock_model(NewsArticle)
    news_article_98.should_receive(:title).and_return("MyString")
    news_article_98.should_receive(:title_permalink).and_return("MyString")
    news_article_98.should_receive(:text).and_return("MyText")
    news_article_98.should_receive(:publish_at).and_return(Time.now)
    news_article_99 = mock_model(NewsArticle)
    news_article_99.should_receive(:title).and_return("MyString")
    news_article_99.should_receive(:title_permalink).and_return("MyString")
    news_article_99.should_receive(:text).and_return("MyText")
    news_article_99.should_receive(:publish_at).and_return(Time.now)

    assigns[:news_articles] = [news_article_98, news_article_99]
  end

  it "should render list of news_articles" do
    render "/news_articles/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

