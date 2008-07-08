require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/new_vehicles/show.html.erb" do
  include NewVehiclesHelper
  
  before(:each) do
    @new_vehicle = mock_model(NewVehicle)
    @new_vehicle.stub!(:model_id).and_return("1")
    @new_vehicle.stub!(:description).and_return("MyText")
    @new_vehicle.stub!(:year).and_return("1")
    @new_vehicle.stub!(:enabled).and_return(false)

    assigns[:new_vehicle] = @new_vehicle
  end

  it "should render attributes in <p>" do
    render "/new_vehicles/show.html.erb"
    response.should have_text(/MyText/)
    response.should have_text(/1/)
    response.should have_text(/als/)
  end
end

