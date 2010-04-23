require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::SpecialsController do
  
  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /specials" do

    before(:each) do
      @special = mock_model(Special)
      Special.stub!(:find).and_return([@special])
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
      Special.should_receive(:find).and_return([@special])
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
      Special.stub!(:paginate).and_return(@specials)
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
      Special.should_receive(:paginate).and_return(@specials)
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

  describe "handling GET /specials/new" do

    before(:each) do
      @special = mock_model(Special)
      Special.stub!(:new).and_return(@special)
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
  
    it "should create an new special" do
      Special.should_receive(:new).and_return(@special)
      do_get
    end
  
    it "should not save the new special" do
      @special.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new special for the view" do
      do_get
      assigns[:special].should equal(@special)
    end
  end

  describe "handling GET /specials/1/edit" do

    before(:each) do
      @special = mock_model(Special)
      Special.stub!(:find).and_return(@special)
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
  
    it "should find the special requested" do
      Special.should_receive(:find).and_return(@special)
      do_get
    end
  
    it "should assign the found Special for the view" do
      do_get
      assigns[:special].should equal(@special)
    end
  end

  describe "handling POST /specials" do

    before(:each) do
      @special = mock_model(Special, :to_param => "1")
      Special.stub!(:new).and_return(@special)
    end
    
    describe "with successful save" do
  
      def do_post
        @special.should_receive(:save).and_return(true)
        post :create, :special => {}
      end
  
      it "should create a new special" do
        Special.should_receive(:new).with({}).and_return(@special)
        do_post
      end

      it "should redirect to the new special" do
        do_post
        response.should redirect_to(admin_special_path("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @special.should_receive(:save).and_return(false)
        post :create, :special => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /specials/1" do

    before(:each) do
      @special = mock_model(Special, :to_param => "1")
      Special.stub!(:find).and_return(@special)
    end
    
    describe "with successful update" do

      def do_put
        @special.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the special requested" do
        Special.should_receive(:find).with("1").and_return(@special)
        do_put
      end

      it "should update the found special" do
        do_put
        assigns(:special).should equal(@special)
      end

      it "should assign the found special for the view" do
        do_put
        assigns(:special).should equal(@special)
      end

      it "should redirect to the special" do
        do_put
        response.should redirect_to(admin_special_path("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @special.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /specials/1" do

    before(:each) do
      @special = mock_model(Special, :destroy => true)
      Special.stub!(:find).and_return(@special)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the special requested" do
      Special.should_receive(:find).with("1").and_return(@special)
      do_delete
    end
  
    it "should call destroy on the found special" do
      @special.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the specials list" do
      do_delete
      response.should redirect_to(admin_specials_path)
    end
  end
end
