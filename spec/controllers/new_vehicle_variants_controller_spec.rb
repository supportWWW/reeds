require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewVehicleVariantsController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end

  describe "handling DELETE /new_vehicle_variants/1" do

    before(:each) do
      @new_vehicle_variant = mock_model(NewVehicleVariant, :destroy => true)
      NewVehicleVariant.stub!(:find).and_return(@new_vehicle_variant)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the new_vehicle_variant requested" do
      NewVehicleVariant.should_receive(:find).with("1").and_return(@new_vehicle_variant)
      do_delete
    end
  
    it "should call destroy on the found new_vehicle_variant" do
      @new_vehicle_variant.should_receive(:destroy)
      do_delete
    end
  
  end

end
