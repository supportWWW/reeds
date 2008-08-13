require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::AccessoriesController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end

  describe "handling DELETE /accessories/1" do

    before(:each) do
      @accessory = mock_model(Accessory, :destroy => true)
      Accessory.stub!(:find).and_return(@accessory)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the accessory requested" do
      Accessory.should_receive(:find).with("1").and_return(@accessory)
      do_delete
    end
  
    it "should call destroy on the found accessory" do
      @accessory.should_receive(:destroy)
      do_delete
    end
  
  end

end
