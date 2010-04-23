require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BranchesController do
  
  describe "handling GET /branches" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:find).and_return([@branch])
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
  
    it "should find all branches" do
      Branch.should_receive(:find).with(:all, :order => 'name asc').and_return([@branch])
      do_get
    end
  
    it "should assign the found branches for the view" do
      do_get
      assigns[:branches].should == [@branch]
    end
  end

  describe "handling GET /branches.xml" do

    before(:each) do
      @branches = mock("Array of Branches", :to_xml => "XML")
      Branch.stub!(:find).and_return(@branches)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all branches" do
      Branch.should_receive(:find).with(:all, :order => 'name asc').and_return(@branches)
      do_get
    end
  
    it "should render the found branches as xml" do
      @branches.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /branches/1" do

    before(:each) do
      @branch = mock_model(Branch)
      Branch.stub!(:find).and_return(@branch)
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
  
    it "should find the branch requested" do
      Branch.should_receive(:find).with("1", :include => :assignments).and_return(@branch)
      do_get
    end
  
    it "should assign the found branch for the view" do
      do_get
      assigns[:branch].should equal(@branch)
    end
  end

  describe "handling GET /branches/1.xml" do

    before(:each) do
      @branch = mock_model(Branch, :to_xml => "XML")
      Branch.stub!(:find).and_return(@branch)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the branch requested" do
      Branch.should_receive(:find).with("1", :include => :assignments ).and_return(@branch)
      do_get
    end
  
    it "should render the found branch as xml" do
      @branch.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  
  end

end
