require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleVariantController do

  #Delete these examples and add some real ones
  it "should use NewVehicleVariantController" do
    controller.should be_an_instance_of(NewVehicleVariantController)
  end


  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end
end
