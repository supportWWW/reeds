require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ClassifiedsController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /classifieds" do

    before(:each) do
      @classified = mock_model(Classified)
      Classified.stub!(:find).and_return([@classified])
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
  
    it "should find all classifieds" do
      Classified.should_receive(:find).with(:all).and_return([@classified])
      do_get
    end
  
    it "should assign the found classifieds for the view" do
      do_get
      assigns[:classifieds].should == [@classified]
    end
  end

  describe "handling GET /classifieds.xml" do

    before(:each) do
      @classifieds = mock("Array of Classifieds", :to_xml => "XML")
      Classified.stub!(:find).and_return(@classifieds)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all classifieds" do
      Classified.should_receive(:find).with(:all).and_return(@classifieds)
      do_get
    end
  
    it "should render the found classifieds as xml" do
      @classifieds.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
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

  describe "handling GET /classifieds/new" do

    before(:each) do
      @classified = mock_model(Classified)
      Classified.stub!(:new).and_return(@classified)
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
  
    it "should create an new classified" do
      Classified.should_receive(:new).and_return(@classified)
      do_get
    end
  
    it "should not save the new classified" do
      @classified.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new classified for the view" do
      do_get
      assigns[:classified].should equal(@classified)
    end
  end

  describe "handling GET /classifieds/1/edit" do

    before(:each) do
      @classified = mock_model(Classified)
      Classified.stub!(:find).and_return(@classified)
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
  
    it "should find the classified requested" do
      Classified.should_receive(:find).and_return(@classified)
      do_get
    end
  
    it "should assign the found Classified for the view" do
      do_get
      assigns[:classified].should equal(@classified)
    end
  end

  describe "handling POST /classifieds" do

    before(:each) do
      @classified = mock_model(Classified, :to_param => "1")
      Classified.stub!(:new).and_return(@classified)
    end
    
    describe "with successful save" do
  
      def do_post
        @classified.should_receive(:save).and_return(true)
        post :create, :classified => {}
      end
  
      it "should create a new classified" do
        Classified.should_receive(:new).with({}).and_return(@classified)
        do_post
      end

      it "should redirect to the new classified" do
        do_post
        response.should redirect_to(admin_classified_path("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @classified.should_receive(:save).and_return(false)
        post :create, :classified => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /classifieds/1" do

    before(:each) do
      @classified = mock_model(Classified, :to_param => "1")
      Classified.stub!(:find).and_return(@classified)
    end
    
    describe "with successful update" do

      def do_put
        @classified.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the classified requested" do
        Classified.should_receive(:find).with("1").and_return(@classified)
        do_put
      end

      it "should update the found classified" do
        do_put
        assigns(:classified).should equal(@classified)
      end

      it "should assign the found classified for the view" do
        do_put
        assigns(:classified).should equal(@classified)
      end

      it "should redirect to the classified" do
        do_put
        response.should redirect_to(admin_classified_path("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @classified.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /classifieds/1" do

    before(:each) do
      @classified = mock_model(Classified, :destroy => true)
      Classified.stub!(:find).and_return(@classified)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the classified requested" do
      Classified.should_receive(:find).with("1").and_return(@classified)
      do_delete
    end
  
    it "should call destroy on the found classified" do
      @classified.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the classifieds list" do
      do_delete
      response.should redirect_to(admin_classifieds_path)
    end
  end
  
  describe "loading models" do
    it "should return a single model for no make" do
      get 'load_models'
      response.should be_success
      assigns[:models].size.should == 1
    end

    it "should return models for passing in a make" do
      get 'load_models', :make_id => 1
      response.should be_success
      assigns[:models].size.should > 0
    end
  end
end
