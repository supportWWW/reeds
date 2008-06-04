require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_articles/new.html.erb" do
  include NewsArticlesHelper
  
  before(:each) do
    @news_article = mock_model(NewsArticle)
    @news_article.stub!(:new_record?).and_return(true)
    @news_article.stub!(:title).and_return("MyString")
    @news_article.stub!(:title_permalink).and_return("MyString")
    @news_article.stub!(:text).and_return("MyText")
    @news_article.stub!(:publish_at).and_return(Time.now)
    assigns[:news_article] = @news_article
  end

  it "should render new form" do
    render "/news_articles/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", news_articles_path) do
      with_tag("input#news_article_title[name=?]", "news_article[title]")
      with_tag("input#news_article_title_permalink[name=?]", "news_article[title_permalink]")
      with_tag("textarea#news_article_text[name=?]", "news_article[text]")
    end
  end
end


