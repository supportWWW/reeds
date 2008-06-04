require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_articles/show.html.erb" do
  include NewsArticlesHelper
  
  before(:each) do
    @news_article = mock_model(NewsArticle)
    @news_article.stub!(:title).and_return("MyString")
    @news_article.stub!(:title_permalink).and_return("MyString")
    @news_article.stub!(:text).and_return("MyText")
    @news_article.stub!(:publish_at).and_return(Time.now)

    assigns[:news_article] = @news_article
  end

  it "should render attributes in <p>" do
    render "/news_articles/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

