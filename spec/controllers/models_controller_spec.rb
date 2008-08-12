require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ModelsController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end

  describe "handling GET /models" do

    before(:each) do
      @model = mock_model(Model)
      Model.stub!(:find).and_return([@model])
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
  
    it "should find all models" do
      Model.should_receive(:find).with(:all, {:order=>"makes.name, models.common_name", :limit=>10, :offset=>0, :include=>:make}).and_return([@model])
      do_get
    end
  
    it "should assign the found models for the view" do
      do_get
      assigns[:models].should == [@model]
    end
  end

  describe "handling GET /models.xml" do

    before(:each) do
      @models = mock("Array of Models", :to_xml => "XML")
      Model.stub!(:paginate).and_return(@models)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all models" do
      Model.should_receive(:paginate).and_return(@models)
      do_get
    end
  
    it "should render the found models as xml" do
      @models.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /models/1" do

    before(:each) do
      @model = mock_model(Model)
      Model.stub!(:find).and_return(@model)
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
  
    it "should find the model requested" do
      Model.should_receive(:find).with("1").and_return(@model)
      do_get
    end
  
    it "should assign the found model for the view" do
      do_get
      assigns[:model].should equal(@model)
    end
  end

  describe "handling GET /models/1.xml" do

    before(:each) do
      @model = mock_model(Model, :to_xml => "XML")
      Model.stub!(:find).and_return(@model)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the model requested" do
      Model.should_receive(:find).with("1").and_return(@model)
      do_get
    end
  
    it "should render the found model as xml" do
      @model.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /models/new" do

    before(:each) do
      @model = mock_model(Model)
      Model.stub!(:new).and_return(@model)
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
  
    it "should create an new model" do
      Model.should_receive(:new).and_return(@model)
      do_get
    end
  
    it "should not save the new model" do
      @model.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new model for the view" do
      do_get
      assigns[:model].should equal(@model)
    end
  end

  describe "handling GET /models/1/edit" do

    before(:each) do
      @model = mock_model(Model)
      Model.stub!(:find).and_return(@model)
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
  
    it "should find the model requested" do
      Model.should_receive(:find).and_return(@model)
      do_get
    end
  
    it "should assign the found Model for the view" do
      do_get
      assigns[:model].should equal(@model)
    end
  end

  describe "handling POST /models" do

    before(:each) do
      @model = mock_model(Model, :to_param => "1")
      Model.stub!(:new).and_return(@model)
    end
    
    describe "with successful save" do
  
      def do_post
        @model.should_receive(:save).and_return(true)
        post :create, :model => {}
      end
  
      it "should create a new model" do
        Model.should_receive(:new).with({}).and_return(@model)
        do_post
      end

      it "should redirect to the new model" do
        do_post
        response.should redirect_to(model_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @model.should_receive(:save).and_return(false)
        post :create, :model => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /models/1" do

    before(:each) do
      @model = mock_model(Model, :to_param => "1")
      Model.stub!(:find).and_return(@model)
    end
    
    describe "with successful update" do

      def do_put
        @model.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the model requested" do
        Model.should_receive(:find).with("1").and_return(@model)
        do_put
      end

      it "should update the found model" do
        do_put
        assigns(:model).should equal(@model)
      end

      it "should assign the found model for the view" do
        do_put
        assigns(:model).should equal(@model)
      end

      it "should redirect to the model" do
        do_put
        response.should redirect_to(model_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @model.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /models/1" do

    before(:each) do
      @model = mock_model(Model, :destroy => true)
      Model.stub!(:find).and_return(@model)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the model requested" do
      Model.should_receive(:find).with("1").and_return(@model)
      do_delete
    end
  
    it "should call destroy on the found model" do
      @model.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the models list" do
      do_delete
      response.should redirect_to(admin_models_path)
    end
  end
end
