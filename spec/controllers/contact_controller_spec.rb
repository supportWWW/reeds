require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ContactController do

  #Delete these examples and add some real ones
  it "should use ContactController" do
    controller.should be_an_instance_of(ContactController)
  end


  describe "GET 'sell_your_car'" do
    it "should be successful" do
      get 'sell_your_car'
      response.should be_success
    end
  end

  describe "GET 'load_models'" do
    it "should be successful" do
      get 'load_models', :make_id => 1
      response.should be_success
    end
  end

  describe "GET 'load_model_variants'" do
    it "should be successful" do
      get 'load_model_variants', :model_id => 1
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET find_car" do
    it "should be successful" do
      xhr :post, 'find_car', :form => { :name => "Joerg", :phone => "123", :email => "me@spam.com", :criteria => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end
  
  describe "GET used_vehicle_enquiry" do
    it "should be successful" do
      xhr :post, 'used_vehicle_enquiry', :form => { :name => "Joerg", :phone => "123", :email => "me@spam.com", :vehicle => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end

  describe "GET new_vehicle_enquiry" do
    it "should be successful" do
      xhr :post, 'new_vehicle_enquiry', :form => { :name => "Joerg", :phone => "123", :email => "me@spam.com", :vehicle => "My car" }
      response.should be_success
      assigns[:success].should == true
    end
  end
end
