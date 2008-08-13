require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/news_articles/edit.html.erb" do
  include Admin::NewsArticlesHelper
  
  before do
    @news_article = mock_model(NewsArticle)
    @news_article.stub!(:title).and_return("MyString")
    @news_article.stub!(:title_permalink).and_return("MyString")
    @news_article.stub!(:text).and_return("MyText")
    @news_article.stub!(:author).and_return("Myautor")
    @news_article.stub!(:category_id).and_return( 1 )
    @news_article.stub!(:source_url).and_return( 'test url' )      
    @news_article.stub!(:publish_at).and_return(Time.now)
    assigns[:news_article] = @news_article
  end

  it "should render edit form" do
    render "/admin/news_articles/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_news_article_path(@news_article)}][method=post]") do
      with_tag('input#news_article_title[name=?]', "news_article[title]")
      with_tag('textarea#news_article_text[name=?]', "news_article[text]")
    end
  end
end


