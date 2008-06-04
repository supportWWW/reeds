require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsArticle do
  before(:each) do
    @news_article = NewsArticle.new
  end

  it "should be valid" do
    @news_article.should be_valid
  end
end
