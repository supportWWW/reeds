require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::MakesController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /makes" do

    before(:each) do
      @make = mock_model(Make)
      Make.stub!(:find).and_return([@make])
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
  
    it "should find all makes" do
      Make.should_receive(:find).with(:all, {:order=>"name"}).and_return([@make])
      do_get
    end
  
    it "should assign the found makes for the view" do
      do_get
      assigns[:makes].should == [@make]
    end
  end

  describe "handling GET /makes.xml" do

    before(:each) do
      @makes = mock("Array of Makes", :to_xml => "XML")
      Make.stub!(:find).and_return(@makes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all makes" do
      Make.should_receive(:find).and_return(@makes)
      do_get
    end
  
    it "should render the found makes as xml" do
      @makes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /makes/1" do

    before(:each) do
      @make = mock_model(Make)
      Make.stub!(:find).and_return(@make)
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
  
    it "should find the make requested" do
      Make.should_receive(:find).with("1").and_return(@make)
      do_get
    end
  
    it "should assign the found make for the view" do
      do_get
      assigns[:make].should equal(@make)
    end
  end

  describe "handling GET /makes/1.xml" do

    before(:each) do
      @make = mock_model(Make, :to_xml => "XML")
      Make.stub!(:find).and_return(@make)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the make requested" do
      Make.should_receive(:find).with("1").and_return(@make)
      do_get
    end
  
    it "should render the found make as xml" do
      @make.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /makes/new" do

    before(:each) do
      @make = mock_model(Make)
      Make.stub!(:new).and_return(@make)
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
  
    it "should create an new make" do
      Make.should_receive(:new).and_return(@make)
      do_get
    end
  
    it "should not save the new make" do
      @make.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new make for the view" do
      do_get
      assigns[:make].should equal(@make)
    end
  end

  describe "handling GET /makes/1/edit" do

    before(:each) do
      @make = mock_model(Make)
      Make.stub!(:find).and_return(@make)
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
  
    it "should find the make requested" do
      Make.should_receive(:find).and_return(@make)
      do_get
    end
  
    it "should assign the found Make for the view" do
      do_get
      assigns[:make].should equal(@make)
    end
  end

  describe "handling POST /makes" do

    before(:each) do
      @make = mock_model(Make, :to_param => "1")
      Make.stub!(:new).and_return(@make)
    end
    
    describe "with successful save" do
  
      def do_post
        @make.should_receive(:save).and_return(true)
        post :create, :make => {}
      end
  
      it "should create a new make" do
        Make.should_receive(:new).with({}).and_return(@make)
        do_post
      end

      it "should redirect to the new make" do
        do_post
        response.should redirect_to(admin_makes_path)
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @make.should_receive(:save).and_return(false)
        post :create, :make => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /makes/1" do

    before(:each) do
      @make = mock_model(Make, :to_param => "1")
      Make.stub!(:find).and_return(@make)
    end
    
    describe "with successful update" do

      def do_put
        @make.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the make requested" do
        Make.should_receive(:find).with("1").and_return(@make)
        do_put
      end

      it "should update the found make" do
        do_put
        assigns(:make).should equal(@make)
      end

      it "should assign the found make for the view" do
        do_put
        assigns(:make).should equal(@make)
      end

      it "should redirect to the make" do
        do_put
        response.should redirect_to(admin_makes_path)
      end

    end
    
    describe "with failed update" do

      def do_put
        @make.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /makes/1" do

    before(:each) do
      @make = mock_model(Make, :destroy => true)
      Make.stub!(:find).and_return(@make)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the make requested" do
      Make.should_receive(:find).with("1").and_return(@make)
      do_delete
    end
  
    it "should call destroy on the found make" do
      @make.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the makes list" do
      do_delete
      response.should redirect_to(admin_makes_path)
    end
  end
end
