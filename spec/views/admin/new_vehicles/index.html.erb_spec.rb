require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/new_vehicles/index.html.erb" do
  include Admin::NewVehiclesHelper
  
  before(:each) do
    new_vehicle_98 = mock_model(NewVehicle)
    new_vehicle_98.should_receive(:year).and_return("1")
    new_vehicle_98.should_receive(:enabled).and_return(false)
    new_vehicle_98.should_receive(:humanize).and_return("Human")
    new_vehicle_99 = mock_model(NewVehicle)
    new_vehicle_99.should_receive(:year).and_return("1")
    new_vehicle_99.should_receive(:enabled).and_return(false)
    new_vehicle_99.should_receive(:humanize).and_return("Human")

    assigns[:new_vehicles] = [new_vehicle_98, new_vehicle_99]
    assigns[:new_vehicles].stub!(:total_pages).and_return(1)
  end

  it "should render list of new_vehicles" do
    render "/admin/new_vehicles/index.html.erb"
    response.should have_tag("tr>td", "Human", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "No", 2)
  end
end

