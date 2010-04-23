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
  
  end

  describe "handling GET /new_vehicles.xml" do

    before(:each) do
      @new_vehicles = mock("Array of NewVehicles", :to_xml => "XML")
      NewVehicle.stub!(:paginate).and_return(@new_vehicles)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

  end

  describe "handling GET /new_vehicles/1" do

    before(:each) do
      @new_vehicle = mock_model(NewVehicle)
      NewVehicle.stub!(:find_by_permalink).and_return(@new_vehicle)
    end
  
    def do_get
      get :show, :id => "permalink1"
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
      NewVehicle.should_receive(:find_by_permalink).with("permalink1").and_return(@new_vehicle)
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
      NewVehicle.stub!(:find_by_permalink).and_return(@new_vehicle)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "permalink1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the new_vehicle requested" do
      NewVehicle.should_receive(:find_by_permalink).with("permalink1").and_return(@new_vehicle)
      do_get
    end
  
    it "should render the found new_vehicle as xml" do
      @new_vehicle.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

end
