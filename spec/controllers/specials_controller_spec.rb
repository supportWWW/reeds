require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SpecialsController do
  
  describe "handling GET /specials" do

    before(:each) do
      @special = mock_model(Special)
      Special.stub!(:enabled).and_return([@special])
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
  
    it "should find all specials" do
      Special.should_receive(:enabled).and_return([@special])
      do_get
    end
  
    it "should assign the found specials for the view" do
      do_get
      assigns[:specials].should == [@special]
    end
  end

  describe "handling GET /specials.xml" do

    before(:each) do
      @specials = mock("Array of Specials", :to_xml => "XML")
      Special.stub!(:find).and_return(@specials)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all specials" do
      Special.should_receive(:enabled).and_return(@specials)
      do_get
    end
  
    it "should render the found specials as xml" do
      @specials.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /specials/1" do

    before(:each) do
      @special = mock_model(Special)
      Special.stub!(:find).and_return(@special)
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
  
    it "should find the special requested" do
      Special.should_receive(:find).with("1").and_return(@special)
      do_get
    end
  
    it "should assign the found special for the view" do
      do_get
      assigns[:special].should equal(@special)
    end
  end

  describe "handling GET /specials/1.xml" do

    before(:each) do
      @special = mock_model(Special, :to_xml => "XML")
      Special.stub!(:find).and_return(@special)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the special requested" do
      Special.should_receive(:find).with("1").and_return(@special)
      do_get
    end
  
    it "should render the found special as xml" do
      @special.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "GET enquire" do
    it "should be successful" do
      xhr :post, 'enquire', :form => { :name => "Joerg", :phone => "123", :email => "me@spam.com", :special => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end

end
