require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicle do
  before(:each) do
    @new_vehicle = NewVehicle.new
  end

  it "should be NewVehicle" do
    @new_vehicle.class.should == NewVehicle
  end
end
