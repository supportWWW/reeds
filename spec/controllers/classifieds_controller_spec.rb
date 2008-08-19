require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ClassifiedsController do

  describe "handling GET /classifieds" do

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
  
  end

  describe "handling GET /classifieds/1" do

    before(:each) do
      @classified = mock_model(Classified)
      Classified.stub!(:find).and_return(@classified)
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
  
    it "should find the classified requested" do
      Classified.should_receive(:find).with("1").and_return(@classified)
      do_get
    end
  
    it "should assign the found classified for the view" do
      do_get
      assigns[:classified].should equal(@classified)
    end
  end

  describe "handling GET /classifieds/1.xml" do

    before(:each) do
      @classified = mock_model(Classified, :to_xml => "XML")
      Classified.stub!(:find).and_return(@classified)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the classified requested" do
      Classified.should_receive(:find).with("1").and_return(@classified)
      do_get
    end
  
    it "should render the found classified as xml" do
      @classified.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

end
