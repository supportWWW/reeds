require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ImporterController do

  #Delete these examples and add some real ones
  it "should use ImporterController" do
    controller.should be_an_instance_of(ImporterController)
  end


  describe "GET 'import_stock'" do
    it "should be successful" do
      get 'import_stock'
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
