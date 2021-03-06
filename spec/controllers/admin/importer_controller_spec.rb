require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ImporterController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  
  #Delete these examples and add some real ones
  it "should use ImporterController" do
    controller.should be_an_instance_of(Admin::ImporterController)
  end


  describe "GET 'import_stock'" do
    it "should be successful" do
      get 'import_stock'
      response.should be_success
    end
  end

  describe "GET 'import_cyberstock'" do
    it "should be successful" do
      get 'import_cyberstock'
      response.should be_success
    end
  end

  describe "GET 'import_new_vehicles'" do
    it "should be successful" do
      get 'import_new_vehicles', :new_vehicle_id => 1
      response.should be_success
    end
  end

  describe "GET 'import_accessories'" do
    it "should be successful" do
      get 'import_accessories', :new_vehicle_id => 1
      response.should be_success
    end
  end

  describe "GET 'import_mm'" do
    it "should be successful" do
      get 'import_mm'
      response.should be_success
    end
  end
end
