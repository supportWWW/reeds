require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsArticlesController do
  
  describe "handling GET /news_articles" do

    before(:each) do
      @news_article = mock_model(NewsArticle)
      NewsArticle.stub!(:find).and_return([@news_article])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all news_articles" do
      NewsArticle.should_receive(:find).and_return([@news_article])
      do_get
    end
  
    it "should assign the found news_articles for the view" do
      do_get
      assigns[:news_articles].should == [@news_article]
    end
  end

  describe "handling GET /news_articles.xml" do

    before(:each) do
      @news_articles = mock("Array of NewsArticles", :to_xml => "XML")
      NewsArticle.stub!(:paginate).and_return(@news_articles)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all news_articles" do
      NewsArticle.should_receive(:paginate).and_return(@news_articles)
      do_get
    end
  
    it "should render the found news_articles as xml" do
      @news_articles.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /news_articles/1" do

    before(:each) do
      @news_article = mock_model(NewsArticle, :id => 1)
      NewsArticle.stub!(:find).with("1").and_return(@news_article)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the news_article requested" do
      NewsArticle.should_receive(:find).with("1").and_return(@news_article)
      do_get
    end
  
    it "should assign the found news_article for the view" do
      do_get
      assigns[:news_article].should equal(@news_article)
    end
  end

  describe "handling GET /news_articles/1.xml" do

    before(:each) do
      @news_article = mock_model(NewsArticle, :to_xml => "XML")
      NewsArticle.stub!(:find).and_return(@news_article)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the news_article requested" do
      NewsArticle.should_receive(:find).with("1").and_return(@news_article)
      do_get
    end
  
    it "should render the found news_article as xml" do
      @news_article.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

end
