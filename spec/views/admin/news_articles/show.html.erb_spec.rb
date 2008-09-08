require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/news_articles/show.html.erb" do
  include Admin::NewsArticlesHelper
  
  before(:each) do
    @news_article = mock_model(NewsArticle)
    @news_article.stub!(:title).and_return("MyString")
    @news_article.stub!(:title_permalink).and_return("MyString")
    @news_article.stub!(:rendered_text).and_return("rendered text")
    @news_article.stub!(:author).and_return("my author")
    @news_article.stub!(:source_url).and_return("my source url")
    @news_article.stub!(:publish_at).and_return(Time.now)
    @news_article.stub!(:category).and_return( Category.new( :name => 'test' ) )
    @news_article.stub!(:image).and_return(mock_model(Image, :public_filename => ""))
    
    assigns[:news_article] = @news_article
  end

  it "should render attributes in <p>" do
    render "/admin/news_articles/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/rendered text/)
    response.should have_text(/my source url/)
    response.should have_text(/my author/)
  end
end
