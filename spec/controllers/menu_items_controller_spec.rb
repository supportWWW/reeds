require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MenuItemsController do
  
    before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  describe "handling GET /menu_items" do

    before(:each) do
      @menu_item = mock_model(MenuItem)
      MenuItem.stub!(:find).and_return([@menu_item])
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
  
    it "should find all menu_items" do
      MenuItem.should_receive(:find).and_return([@menu_item])
      do_get
    end
  
    it "should assign the found menu_items for the view" do
      do_get
      assigns[:menu_items].should == [@menu_item]
    end
  end

  describe "handling GET /menu_items.xml" do

    before(:each) do
      @menu_items = mock("Array of MenuItems", :to_xml => "XML")
      MenuItem.stub!(:find).and_return(@menu_items)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all menu_items" do
      MenuItem.should_receive(:find).and_return(@menu_items)
      do_get
    end
  
    it "should render the found menu_items as xml" do
      @menu_items.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /menu_items/1" do

    before(:each) do
      @menu_item = mock_model(MenuItem)
      MenuItem.stub!(:find).and_return(@menu_item)
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
  
    it "should find the menu_item requested" do
      MenuItem.should_receive(:find).with("1").and_return(@menu_item)
      do_get
    end
  
    it "should assign the found menu_item for the view" do
      do_get
      assigns[:menu_item].should equal(@menu_item)
    end
  end

  describe "handling GET /menu_items/1.xml" do

    before(:each) do
      @menu_item = mock_model(MenuItem, :to_xml => "XML")
      MenuItem.stub!(:find).and_return(@menu_item)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the menu_item requested" do
      MenuItem.should_receive(:find).with("1").and_return(@menu_item)
      do_get
    end
  
    it "should render the found menu_item as xml" do
      @menu_item.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /menu_items/new" do

    before(:each) do
      @menu_item = mock_model(MenuItem)
      MenuItem.stub!(:new).and_return(@menu_item)
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
  
    it "should create an new menu_item" do
      MenuItem.should_receive(:new).and_return(@menu_item)
      do_get
    end
  
    it "should not save the new menu_item" do
      @menu_item.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new menu_item for the view" do
      do_get
      assigns[:menu_item].should equal(@menu_item)
    end
  end

  describe "handling GET /menu_items/1/edit" do

    before(:each) do
      @menu_item = mock_model(MenuItem)
      MenuItem.stub!(:find).and_return(@menu_item)
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
  
    it "should find the menu_item requested" do
      MenuItem.should_receive(:find).and_return(@menu_item)
      do_get
    end
  
    it "should assign the found MenuItem for the view" do
      do_get
      assigns[:menu_item].should equal(@menu_item)
    end
  end

  describe "handling POST /menu_items" do

    before(:each) do
      @menu_item = mock_model(MenuItem, :to_param => "1")
      MenuItem.stub!(:new).and_return(@menu_item)
    end
    
    describe "with successful save" do
  
      def do_post
        @menu_item.should_receive(:save).and_return(true)
        post :create, :menu_item => {}
      end
  
      it "should create a new menu_item" do
        MenuItem.should_receive(:new).with({}).and_return(@menu_item)
        do_post
      end

      it "should redirect to the new menu_item" do
        do_post
        response.should redirect_to(admin_menu_items_path)
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @menu_item.should_receive(:save).and_return(false)
        post :create, :menu_item => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /menu_items/1" do

    before(:each) do
      @menu_item = mock_model(MenuItem, :to_param => "1")
      MenuItem.stub!(:find).and_return(@menu_item)
    end
    
    describe "with successful update" do

      def do_put
        @menu_item.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the menu_item requested" do
        MenuItem.should_receive(:find).with("1").and_return(@menu_item)
        do_put
      end

      it "should update the found menu_item" do
        do_put
        assigns(:menu_item).should equal(@menu_item)
      end

      it "should assign the found menu_item for the view" do
        do_put
        assigns(:menu_item).should equal(@menu_item)
      end

      it "should redirect to the menu_item" do
        do_put
        response.should redirect_to(admin_menu_items_path)
      end

    end
    
    describe "with failed update" do

      def do_put
        @menu_item.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /menu_items/1" do

    before(:each) do
      @menu_item = mock_model(MenuItem, :destroy => true)
      MenuItem.stub!(:find).and_return(@menu_item)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the menu_item requested" do
      MenuItem.should_receive(:find).with("1").and_return(@menu_item)
      do_delete
    end
  
    it "should call destroy on the found menu_item" do
      @menu_item.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the menu_items list" do
      do_delete
      response.should redirect_to(admin_menu_items_path)
    end
  end
end
