require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/new_vehicles/show.html.erb" do
  include NewVehiclesHelper
  
  before(:each) do
    @new_vehicle = mock_model(NewVehicle)
    @new_vehicle.stub!(:model_id).and_return("1")
    @new_vehicle.stub!(:model_range).and_return(ModelRange.new(:name => "Model Range"))
    @new_vehicle.stub!(:new_vehicle_variants).and_return(mock("Array of variants", :count => 1, :each => [mock_model(NewVehicleVariant, :name => "New Vehicle Variant")]))
    @new_vehicle.stub!(:accessories).and_return(mock("Array of accessories", :count => 1, :each => [mock_model(Accessory, :name => "Accessory")]))
    @new_vehicle.stub!(:images).and_return(mock("Array of images", :count => 1, :each => [mock_model(Image)]))
    @new_vehicle.stub!(:attachments).and_return(mock("Array of attachments", :count => 1, :each => [mock_model(Attachment)]))
    @new_vehicle.stub!(:description).and_return("MyText")
    @new_vehicle.stub!(:year).and_return("1")
    @new_vehicle.stub!(:enabled).and_return(false)
    @new_vehicle.stub!(:humanize).and_return("Hi")
    @new_vehicle.stub!(:enabled?).and_return(true)

    assigns[:new_vehicle] = @new_vehicle
  end

  it "should render attributes in <p>" do
    render "/new_vehicles/show.html.erb"
  end
end

