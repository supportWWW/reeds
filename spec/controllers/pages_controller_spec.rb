require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  
  describe "handling GET /pages" do

    before(:each) do
      @page = mock_model(Page)
      Page.stub!(:find).and_return([@page])
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
  
    it "should find all pages" do
      Page.should_receive(:find).and_return([@page])
      do_get
    end
  
    it "should assign the found pages for the view" do
      do_get
      assigns[:pages].should == [@page]
    end
  end

  describe "handling GET /pages.xml" do

    before(:each) do
      @pages = mock("Array of Pages", :to_xml => "XML")
      Page.stub!(:paginate).and_return(@pages)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all pages" do
      Page.should_receive(:paginate).and_return(@pages)
      do_get
    end
  
    it "should render the found pages as xml" do
      @pages.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /pages/1" do

    before(:each) do
      @page = mock_model(Page)
      Page.stub!(:find).and_return(@page)
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
  
    it "should find the page requested" do
      Page.should_receive(:find).with("1").and_return(@page)
      do_get
    end
  
    it "should assign the found page for the view" do
      do_get
      assigns[:page].should equal(@page)
    end
  end

  describe "handling GET /pages/1.xml" do

    before(:each) do
      @page = mock_model(Page, :to_xml => "XML")
      Page.stub!(:find).and_return(@page)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the page requested" do
      Page.should_receive(:find).with("1").and_return(@page)
      do_get
    end
  
    it "should render the found page as xml" do
      @page.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

end
