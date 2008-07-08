require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/new_vehicles/new.html.erb" do
  include NewVehiclesHelper
  
  before(:each) do
    @new_vehicle = mock_model(NewVehicle)
    @new_vehicle.stub!(:new_record?).and_return(true)
    @new_vehicle.stub!(:model_id).and_return("1")
    @new_vehicle.stub!(:description).and_return("MyText")
    @new_vehicle.stub!(:year).and_return("1")
    @new_vehicle.stub!(:enabled).and_return(false)
    assigns[:new_vehicle] = @new_vehicle
  end

  it "should render new form" do
    render "/new_vehicles/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", new_vehicles_path) do
      with_tag("textarea#new_vehicle_description[name=?]", "new_vehicle[description]")
      with_tag("input#new_vehicle_year[name=?]", "new_vehicle[year]")
      with_tag("input#new_vehicle_enabled[name=?]", "new_vehicle[enabled]")
    end
  end
end

