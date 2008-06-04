require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsArticlesController do
  
  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
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
      @news_article = mock_model(NewsArticle)
      NewsArticle.stub!(:find).and_return(@news_article)
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

  describe "handling GET /news_articles/new" do

    before(:each) do
      @news_article = mock_model(NewsArticle)
      NewsArticle.stub!(:new).and_return(@news_article)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new news_article" do
      NewsArticle.should_receive(:new).and_return(@news_article)
      do_get
    end
  
    it "should not save the new news_article" do
      @news_article.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new news_article for the view" do
      do_get
      assigns[:news_article].should equal(@news_article)
    end
  end

  describe "handling GET /news_articles/1/edit" do

    before(:each) do
      @news_article = mock_model(NewsArticle)
      NewsArticle.stub!(:find).and_return(@news_article)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the news_article requested" do
      NewsArticle.should_receive(:find).and_return(@news_article)
      do_get
    end
  
    it "should assign the found NewsArticle for the view" do
      do_get
      assigns[:news_article].should equal(@news_article)
    end
  end

  describe "handling POST /news_articles" do

    before(:each) do
      @news_article = mock_model(NewsArticle, :to_param => "1")
      NewsArticle.stub!(:new).and_return(@news_article)
    end
    
    describe "with successful save" do
  
      def do_post
        @news_article.should_receive(:save).and_return(true)
        post :create, :news_article => {}
      end
  
      it "should create a new news_article" do
        NewsArticle.should_receive(:new).with({}).and_return(@news_article)
        do_post
      end

      it "should redirect to the new news_article" do
        do_post
        response.should redirect_to(news_article_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @news_article.should_receive(:save).and_return(false)
        post :create, :news_article => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /news_articles/1" do

    before(:each) do
      @news_article = mock_model(NewsArticle, :to_param => "1")
      NewsArticle.stub!(:find).and_return(@news_article)
    end
    
    describe "with successful update" do

      def do_put
        @news_article.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the news_article requested" do
        NewsArticle.should_receive(:find).with("1").and_return(@news_article)
        do_put
      end

      it "should update the found news_article" do
        do_put
        assigns(:news_article).should equal(@news_article)
      end

      it "should assign the found news_article for the view" do
        do_put
        assigns(:news_article).should equal(@news_article)
      end

      it "should redirect to the news_article" do
        do_put
        response.should redirect_to(news_article_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @news_article.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /news_articles/1" do

    before(:each) do
      @news_article = mock_model(NewsArticle, :destroy => true)
      NewsArticle.stub!(:find).and_return(@news_article)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the news_article requested" do
      NewsArticle.should_receive(:find).with("1").and_return(@news_article)
      do_delete
    end
  
    it "should call destroy on the found news_article" do
      @news_article.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the news_articles list" do
      do_delete
      response.should redirect_to(news_articles_url)
    end
  end
end
