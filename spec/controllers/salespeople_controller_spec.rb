require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SalespeopleController do
  
    before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /salespeople" do

    before(:each) do
      @salesperson = mock_model(Salesperson)
      Salesperson.stub!(:find).and_return([@salesperson])
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
  
    it "should find all salespeople" do
      Salesperson.should_receive(:find).with(:all, :order => 'name asc').and_return([@salesperson])
      do_get
    end
  
    it "should assign the found salespeople for the view" do
      do_get
      assigns[:salespeople].should == [@salesperson]
    end
  end

  describe "handling GET /salespeople.xml" do

    before(:each) do
      @salespeople = mock("Array of Salespeople", :to_xml => "XML")
      Salesperson.stub!(:find).and_return(@salespeople)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all salespeople" do
      Salesperson.should_receive(:find).with(:all, :order => 'name asc').and_return(@salespeople)
      do_get
    end
  
    it "should render the found salespeople as xml" do
      @salespeople.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /salespeople/1" do

    before(:each) do
      @salesperson = mock_model(Salesperson)
      Salesperson.stub!(:find).and_return(@salesperson)
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
  
    it "should find the salesperson requested" do
      Salesperson.should_receive(:find).with("1").and_return(@salesperson)
      do_get
    end
  
    it "should assign the found salesperson for the view" do
      do_get
      assigns[:salesperson].should equal(@salesperson)
    end
  end

  describe "handling GET /salespeople/1.xml" do

    before(:each) do
      @salesperson = mock_model(Salesperson, :to_xml => "XML")
      Salesperson.stub!(:find).and_return(@salesperson)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the salesperson requested" do
      Salesperson.should_receive(:find).with("1").and_return(@salesperson)
      do_get
    end
  
    it "should render the found salesperson as xml" do
      @salesperson.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /salespeople/new" do

    before(:each) do
      @salesperson = mock_model(Salesperson)
      Salesperson.stub!(:new).and_return(@salesperson)
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
  
    it "should create an new salesperson" do
      Salesperson.should_receive(:new).and_return(@salesperson)
      do_get
    end
  
    it "should not save the new salesperson" do
      @salesperson.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new salesperson for the view" do
      do_get
      assigns[:salesperson].should equal(@salesperson)
    end
  end

  describe "handling GET /salespeople/1/edit" do

    before(:each) do
      @salesperson = mock_model(Salesperson)
      Salesperson.stub!(:find).and_return(@salesperson)
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
  
    it "should find the salesperson requested" do
      Salesperson.should_receive(:find).and_return(@salesperson)
      do_get
    end
  
    it "should assign the found Salesperson for the view" do
      do_get
      assigns[:salesperson].should equal(@salesperson)
    end
  end

  describe "handling POST /salespeople" do

    before(:each) do
      @salesperson = mock_model(Salesperson, :to_param => "1")
      Salesperson.stub!(:new).and_return(@salesperson)
    end
    
    describe "with successful save" do
  
      def do_post
        @salesperson.should_receive(:save).and_return(true)
        post :create, :salesperson => {}
      end
  
      it "should create a new salesperson" do
        Salesperson.should_receive(:new).with({}).and_return(@salesperson)
        do_post
      end

      it "should redirect to the new salesperson" do
        do_post
        response.should redirect_to( admin_salespeople_path )
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @salesperson.should_receive(:save).and_return(false)
        post :create, :salesperson => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /salespeople/1" do

    before(:each) do
      @salesperson = mock_model(Salesperson, :to_param => "1")
      Salesperson.stub!(:find).and_return(@salesperson)
    end
    
    describe "with successful update" do

      def do_put
        @salesperson.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the salesperson requested" do
        Salesperson.should_receive(:find).with("1").and_return(@salesperson)
        do_put
      end

      it "should update the found salesperson" do
        do_put
        assigns(:salesperson).should equal(@salesperson)
      end

      it "should assign the found salesperson for the view" do
        do_put
        assigns(:salesperson).should equal(@salesperson)
      end

      it "should redirect to the salesperson" do
        do_put
        response.should redirect_to( admin_salespeople_path )
      end

    end
    
    describe "with failed update" do

      def do_put
        @salesperson.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /salespeople/1" do

    before(:each) do
      @salesperson = mock_model(Salesperson, :destroy => true)
      Salesperson.stub!(:find).and_return(@salesperson)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the salesperson requested" do
      Salesperson.should_receive(:find).with("1").and_return(@salesperson)
      do_delete
    end
  
    it "should call destroy on the found salesperson" do
      @salesperson.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the salespeople list" do
      do_delete
      response.should redirect_to(admin_salespeople_path)
    end
  end
end
