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
end
