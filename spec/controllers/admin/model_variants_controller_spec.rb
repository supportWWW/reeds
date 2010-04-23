require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ModelVariantsController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /model_variants" do

    before(:each) do
      @model_variant = mock_model(ModelVariant)
      ModelVariant.stub!(:find).and_return([@model_variant])
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
  
    it "should find all model_variants" do
      ModelVariant.should_receive(:find).and_return([@model_variant])
      do_get
    end
  
    it "should assign the found model_variants for the view" do
      do_get
      assigns[:model_variants].should == [@model_variant]
    end
  end

  describe "handling GET /model_variants.xml" do

    before(:each) do
      @model_variants = mock("Array of ModelVariants", :to_xml => "XML")
      ModelVariant.stub!(:paginate).and_return(@model_variants)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all model_variants" do
      ModelVariant.should_receive(:paginate).and_return(@model_variants)
      do_get
    end
  
    it "should render the found model_variants as xml" do
      @model_variants.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /model_variants/1" do

    before(:each) do
      @model_variant = mock_model(ModelVariant)
      ModelVariant.stub!(:find).and_return(@model_variant)
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
  
    it "should find the model_variant requested" do
      ModelVariant.should_receive(:find).with("1").and_return(@model_variant)
      do_get
    end
  
    it "should assign the found model_variant for the view" do
      do_get
      assigns[:model_variant].should equal(@model_variant)
    end
  end

  describe "handling GET /model_variants/1.xml" do

    before(:each) do
      @model_variant = mock_model(ModelVariant, :to_xml => "XML")
      ModelVariant.stub!(:find).and_return(@model_variant)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the model_variant requested" do
      ModelVariant.should_receive(:find).with("1").and_return(@model_variant)
      do_get
    end
  
    it "should render the found model_variant as xml" do
      @model_variant.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /model_variants/new" do

    before(:each) do
      @model_variant = mock_model(ModelVariant)
      ModelVariant.stub!(:new).and_return(@model_variant)
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
  
    it "should create an new model_variant" do
      ModelVariant.should_receive(:new).and_return(@model_variant)
      do_get
    end
  
    it "should not save the new model_variant" do
      @model_variant.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new model_variant for the view" do
      do_get
      assigns[:model_variant].should equal(@model_variant)
    end
  end

  describe "handling GET /model_variants/1/edit" do

    before(:each) do
      @model_variant = mock_model(ModelVariant)
      ModelVariant.stub!(:find).and_return(@model_variant)
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
  
    it "should find the model_variant requested" do
      ModelVariant.should_receive(:find).and_return(@model_variant)
      do_get
    end
  
    it "should assign the found ModelVariant for the view" do
      do_get
      assigns[:model_variant].should equal(@model_variant)
    end
  end

  describe "handling POST /model_variants" do

    before(:each) do
      @model_variant = mock_model(ModelVariant, :to_param => "1")
      ModelVariant.stub!(:new).and_return(@model_variant)
    end
    
    describe "with successful save" do
  
      def do_post
        @model_variant.should_receive(:save).and_return(true)
        post :create, :model_variant => {}
      end
  
      it "should create a new model_variant" do
        ModelVariant.should_receive(:new).with({}).and_return(@model_variant)
        do_post
      end

      it "should redirect to the new model_variant" do
        do_post
        response.should redirect_to(admin_model_variant_path("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @model_variant.should_receive(:save).and_return(false)
        post :create, :model_variant => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /model_variants/1" do

    before(:each) do
      @model_variant = mock_model(ModelVariant, :to_param => "1")
      ModelVariant.stub!(:find).and_return(@model_variant)
    end
    
    describe "with successful update" do

      def do_put
        @model_variant.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the model_variant requested" do
        ModelVariant.should_receive(:find).with("1").and_return(@model_variant)
        do_put
      end

      it "should update the found model_variant" do
        do_put
        assigns(:model_variant).should equal(@model_variant)
      end

      it "should assign the found model_variant for the view" do
        do_put
        assigns(:model_variant).should equal(@model_variant)
      end

      it "should redirect to the model_variant" do
        do_put
        response.should redirect_to(admin_model_variant_path("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @model_variant.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /model_variants/1" do

    before(:each) do
      @model_variant = mock_model(ModelVariant, :destroy => true)
      ModelVariant.stub!(:find).and_return(@model_variant)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the model_variant requested" do
      ModelVariant.should_receive(:find).with("1").and_return(@model_variant)
      do_delete
    end
  
    it "should call destroy on the found model_variant" do
      @model_variant.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the model_variants list" do
      do_delete
      response.should redirect_to(admin_model_variants_path)
    end
  end
end
