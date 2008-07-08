require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleVariant do
  before(:each) do
    @new_vehicle_variant = NewVehicleVariant.new
  end

  it "should be valid" do
    @new_vehicle_variant.should be_valid
  end
end
