require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicle do
  before(:each) do
    @new_vehicle = NewVehicle.new
  end

  it "should be valid" do
    @new_vehicle.should be_valid
  end
end
