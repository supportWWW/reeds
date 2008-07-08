require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehiclesController do
  describe "handling GET /new_vehicles" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle)
      NewVehicle.stub!(:find).and_return([@new_vehicle])
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
  
    it "should find all new_vehicles" do
      NewVehicle.should_receive(:find).with(:all).and_return([@new_vehicle])
      do_get
    end
  
    it "should assign the found new_vehicles for the view" do
      do_get
      assigns[:new_vehicles].should == [@new_vehicle]
    end
  end

  describe "handling GET /new_vehicles.xml" do

    before(:each) do
      @new_vehicles = mock("Array of NewVehicles", :to_xml => "XML")
      NewVehicle.stub!(:find).and_return(@new_vehicles)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all new_vehicles" do
      NewVehicle.should_receive(:find).with(:all).and_return(@new_vehicles)
      do_get
    end
  
    it "should render the found new_vehicles as xml" do
      @new_vehicles.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /new_vehicles/1" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle)
      NewVehicle.stub!(:find).and_return(@new_vehicle)
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
  
    it "should find the new_vehicle requested" do
      NewVehicle.should_receive(:find).with("1").and_return(@new_vehicle)
      do_get
    end
  
    it "should assign the found new_vehicle for the view" do
      do_get
      assigns[:new_vehicle].should equal(@new_vehicle)
    end
  end

  describe "handling GET /new_vehicles/1.xml" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle, :to_xml => "XML")
      NewVehicle.stub!(:find).and_return(@new_vehicle)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the new_vehicle requested" do
      NewVehicle.should_receive(:find).with("1").and_return(@new_vehicle)
      do_get
    end
  
    it "should render the found new_vehicle as xml" do
      @new_vehicle.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /new_vehicles/new" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle)
      NewVehicle.stub!(:new).and_return(@new_vehicle)
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
  
    it "should create an new new_vehicle" do
      NewVehicle.should_receive(:new).and_return(@new_vehicle)
      do_get
    end
  
    it "should not save the new new_vehicle" do
      @new_vehicle.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new new_vehicle for the view" do
      do_get
      assigns[:new_vehicle].should equal(@new_vehicle)
    end
  end

  describe "handling GET /new_vehicles/1/edit" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle)
      NewVehicle.stub!(:find).and_return(@new_vehicle)
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
  
    it "should find the new_vehicle requested" do
      NewVehicle.should_receive(:find).and_return(@new_vehicle)
      do_get
    end
  
    it "should assign the found NewVehicle for the view" do
      do_get
      assigns[:new_vehicle].should equal(@new_vehicle)
    end
  end

  describe "handling POST /new_vehicles" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle, :to_param => "1")
      NewVehicle.stub!(:new).and_return(@new_vehicle)
    end
    
    describe "with successful save" do
  
      def do_post
        @new_vehicle.should_receive(:save).and_return(true)
        post :create, :new_vehicle => {}
      end
  
      it "should create a new new_vehicle" do
        NewVehicle.should_receive(:new).with({}).and_return(@new_vehicle)
        do_post
      end

      it "should redirect to the new new_vehicle" do
        do_post
        response.should redirect_to(new_vehicle_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @new_vehicle.should_receive(:save).and_return(false)
        post :create, :new_vehicle => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /new_vehicles/1" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle, :to_param => "1")
      NewVehicle.stub!(:find).and_return(@new_vehicle)
    end
    
    describe "with successful update" do

      def do_put
        @new_vehicle.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the new_vehicle requested" do
        NewVehicle.should_receive(:find).with("1").and_return(@new_vehicle)
        do_put
      end

      it "should update the found new_vehicle" do
        do_put
        assigns(:new_vehicle).should equal(@new_vehicle)
      end

      it "should assign the found new_vehicle for the view" do
        do_put
        assigns(:new_vehicle).should equal(@new_vehicle)
      end

      it "should redirect to the new_vehicle" do
        do_put
        response.should redirect_to(new_vehicle_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @new_vehicle.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /new_vehicles/1" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle, :destroy => true)
      NewVehicle.stub!(:find).and_return(@new_vehicle)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the new_vehicle requested" do
      NewVehicle.should_receive(:find).with("1").and_return(@new_vehicle)
      do_delete
    end
  
    it "should call destroy on the found new_vehicle" do
      @new_vehicle.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the new_vehicles list" do
      do_delete
      response.should redirect_to(new_vehicles_url)
    end
  end
end
