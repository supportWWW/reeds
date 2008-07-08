require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccessoriesController do

  #Delete these examples and add some real ones
  it "should use AccessoriesController" do
    controller.should be_an_instance_of(AccessoriesController)
  end


  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_success
    end
  end
end
