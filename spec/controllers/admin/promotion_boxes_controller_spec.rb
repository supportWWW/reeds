require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::PromotionBoxesController do
  
    before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /promotion_boxes" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox)
      PromotionBox.stub!(:find).and_return([@promotion_box])
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
  
    it "should find all promotion_boxes" do
      PromotionBox.should_receive(:find).with(:all).and_return([@promotion_box])
      do_get
    end
  
    it "should assign the found promotion_boxes for the view" do
      do_get
      assigns[:promotion_boxes].should == [@promotion_box]
    end
  end

  describe "handling GET /promotion_boxes.xml" do

    before(:each) do
      @promotion_boxes = mock("Array of PromotionBoxes", :to_xml => "XML")
      PromotionBox.stub!(:find).and_return(@promotion_boxes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all promotion_boxes" do
      PromotionBox.should_receive(:find).with(:all).and_return(@promotion_boxes)
      do_get
    end
  
    it "should render the found promotion_boxes as xml" do
      @promotion_boxes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /promotion_boxes/1" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox)
      PromotionBox.stub!(:find).and_return(@promotion_box)
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
  
    it "should find the promotion_box requested" do
      PromotionBox.should_receive(:find).with("1").and_return(@promotion_box)
      do_get
    end
  
    it "should assign the found promotion_box for the view" do
      do_get
      assigns[:promotion_box].should equal(@promotion_box)
    end
  end

  describe "handling GET /promotion_boxes/1.xml" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox, :to_xml => "XML")
      PromotionBox.stub!(:find).and_return(@promotion_box)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the promotion_box requested" do
      PromotionBox.should_receive(:find).with("1").and_return(@promotion_box)
      do_get
    end
  
    it "should render the found promotion_box as xml" do
      @promotion_box.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /promotion_boxes/new" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox)
      PromotionBox.stub!(:new).and_return(@promotion_box)
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
  
    it "should create an new promotion_box" do
      PromotionBox.should_receive(:new).and_return(@promotion_box)
      do_get
    end
  
    it "should not save the new promotion_box" do
      @promotion_box.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new promotion_box for the view" do
      do_get
      assigns[:promotion_box].should equal(@promotion_box)
    end
  end

  describe "handling GET /promotion_boxes/1/edit" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox)
      PromotionBox.stub!(:find).and_return(@promotion_box)
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
  
    it "should find the promotion_box requested" do
      PromotionBox.should_receive(:find).and_return(@promotion_box)
      do_get
    end
  
    it "should assign the found PromotionBox for the view" do
      do_get
      assigns[:promotion_box].should equal(@promotion_box)
    end
  end

  describe "handling POST /promotion_boxes" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox, :to_param => "1")
      PromotionBox.stub!(:new).and_return(@promotion_box)
    end
    
    describe "with successful save" do
  
      def do_post
        @promotion_box.should_receive(:save).and_return(true)
        post :create, :promotion_box => {}
      end
  
      it "should create a new promotion_box" do
        PromotionBox.should_receive(:new).with({}).and_return(@promotion_box)
        do_post
      end

      it "should redirect to the new promotion_box" do
        do_post
        response.should redirect_to( admin_promotion_boxes_path )
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @promotion_box.should_receive(:save).and_return(false)
        post :create, :promotion_box => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /promotion_boxes/1" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox, :to_param => "1")
      PromotionBox.stub!(:find).and_return(@promotion_box)
    end
    
    describe "with successful update" do

      def do_put
        @promotion_box.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the promotion_box requested" do
        PromotionBox.should_receive(:find).with("1").and_return(@promotion_box)
        do_put
      end

      it "should update the found promotion_box" do
        do_put
        assigns(:promotion_box).should equal(@promotion_box)
      end

      it "should assign the found promotion_box for the view" do
        do_put
        assigns(:promotion_box).should equal(@promotion_box)
      end

      it "should redirect to the promotion_box" do
        do_put
        response.should redirect_to( admin_promotion_boxes_path )
      end

    end
    
    describe "with failed update" do

      def do_put
        @promotion_box.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /promotion_boxes/1" do

    before(:each) do
      @promotion_box = mock_model(PromotionBox, :destroy => true)
      PromotionBox.stub!(:find).and_return(@promotion_box)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the promotion_box requested" do
      PromotionBox.should_receive(:find).with("1").and_return(@promotion_box)
      do_delete
    end
  
    it "should call destroy on the found promotion_box" do
      @promotion_box.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the promotion_boxes list" do
      do_delete
      response.should redirect_to(admin_promotion_boxes_path)
    end
  end
end
