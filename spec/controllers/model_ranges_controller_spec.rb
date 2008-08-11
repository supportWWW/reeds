require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelRangesController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /model_ranges" do

    before(:each) do
      @model_range = mock_model(ModelRange)
      ModelRange.stub!(:find).and_return([@model_range])
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
  
    it "should find all model_ranges" do
      ModelRange.should_receive(:find).with(:all, {:order=>"makes.name, model_ranges.name", :limit=>10, :offset=>0, :include=>:make}).and_return([@model_range])
      do_get
    end
  
    it "should assign the found model_ranges for the view" do
      do_get
      assigns[:model_ranges].should == [@model_range]
    end
  end

  describe "handling GET /model_ranges.xml" do

    before(:each) do
      @model_ranges = mock("Array of ModelRanges", :to_xml => "XML")
      ModelRange.stub!(:paginate).and_return(@model_ranges)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all model_ranges" do
      ModelRange.should_receive(:paginate).and_return(@model_ranges)
      do_get
    end
  
    it "should render the found model_ranges as xml" do
      @model_ranges.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /model_ranges/1" do

    before(:each) do
      @model_range = mock_model(ModelRange)
      ModelRange.stub!(:find).and_return(@model_range)
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
  
    it "should find the model_range requested" do
      ModelRange.should_receive(:find).with("1").and_return(@model_range)
      do_get
    end
  
    it "should assign the found model_range for the view" do
      do_get
      assigns[:model_range].should equal(@model_range)
    end
  end

  describe "handling GET /model_ranges/1.xml" do

    before(:each) do
      @model_range = mock_model(ModelRange, :to_xml => "XML")
      ModelRange.stub!(:find).and_return(@model_range)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the model_range requested" do
      ModelRange.should_receive(:find).with("1").and_return(@model_range)
      do_get
    end
  
    it "should render the found model_range as xml" do
      @model_range.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /model_ranges/new" do

    before(:each) do
      @model_range = mock_model(ModelRange)
      ModelRange.stub!(:new).and_return(@model_range)
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
  
    it "should create an new model_range" do
      ModelRange.should_receive(:new).and_return(@model_range)
      do_get
    end
  
    it "should not save the new model_range" do
      @model_range.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new model_range for the view" do
      do_get
      assigns[:model_range].should equal(@model_range)
    end
  end

  describe "handling GET /model_ranges/1/edit" do

    before(:each) do
      @model_range = mock_model(ModelRange)
      ModelRange.stub!(:find).and_return(@model_range)
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
  
    it "should find the model_range requested" do
      ModelRange.should_receive(:find).and_return(@model_range)
      do_get
    end
  
    it "should assign the found ModelRange for the view" do
      do_get
      assigns[:model_range].should equal(@model_range)
    end
  end

  describe "handling POST /model_ranges" do

    before(:each) do
      @model_range = mock_model(ModelRange, :to_param => "1")
      ModelRange.stub!(:new).and_return(@model_range)
    end
    
    describe "with successful save" do
  
      def do_post
        @model_range.should_receive(:save).and_return(true)
        post :create, :model_range => {}
      end
  
      it "should create a new model_range" do
        ModelRange.should_receive(:new).with({}).and_return(@model_range)
        do_post
      end

      it "should redirect to the new model_range" do
        do_post
        response.should redirect_to(model_ranges_url)
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @model_range.should_receive(:save).and_return(false)
        post :create, :model_range => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /model_ranges/1" do

    before(:each) do
      @model_range = mock_model(ModelRange, :to_param => "1")
      ModelRange.stub!(:find).and_return(@model_range)
    end
    
    describe "with successful update" do

      def do_put
        @model_range.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the model_range requested" do
        ModelRange.should_receive(:find).with("1").and_return(@model_range)
        do_put
      end

      it "should update the found model_range" do
        do_put
        assigns(:model_range).should equal(@model_range)
      end

      it "should assign the found model_range for the view" do
        do_put
        assigns(:model_range).should equal(@model_range)
      end

      it "should redirect to the model_range" do
        do_put
        response.should redirect_to(model_ranges_url)
      end

    end
    
    describe "with failed update" do

      def do_put
        @model_range.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /model_ranges/1" do

    before(:each) do
      @model_range = mock_model(ModelRange, :destroy => true)
      ModelRange.stub!(:find).and_return(@model_range)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the model_range requested" do
      ModelRange.should_receive(:find).with("1").and_return(@model_range)
      do_delete
    end
  
    it "should call destroy on the found model_range" do
      @model_range.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the model_ranges list" do
      do_delete
      response.should redirect_to(model_ranges_url)
    end
  end
end
