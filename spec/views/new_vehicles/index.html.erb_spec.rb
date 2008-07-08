require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/new_vehicles/index.html.erb" do
  include NewVehiclesHelper
  
  before(:each) do
    new_vehicle_98 = mock_model(NewVehicle)
    new_vehicle_98.should_receive(:model_id).and_return("1")
    new_vehicle_98.should_receive(:description).and_return("MyText")
    new_vehicle_98.should_receive(:year).and_return("1")
    new_vehicle_98.should_receive(:enabled).and_return(false)
    new_vehicle_99 = mock_model(NewVehicle)
    new_vehicle_99.should_receive(:model_id).and_return("1")
    new_vehicle_99.should_receive(:description).and_return("MyText")
    new_vehicle_99.should_receive(:year).and_return("1")
    new_vehicle_99.should_receive(:enabled).and_return(false)

    assigns[:new_vehicles] = [new_vehicle_98, new_vehicle_99]
  end

  it "should render list of new_vehicles" do
    render "/new_vehicles/index.html.erb"
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

