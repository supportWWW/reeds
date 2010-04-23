require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/new_vehicles/index.html.erb" do
  include NewVehiclesHelper
  
  before(:each) do
  end

  it "should render list of new_vehicles" do
    render "/new_vehicles/index.html.erb"
  end
end

