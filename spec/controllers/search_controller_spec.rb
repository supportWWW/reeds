require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do

  #Delete these examples and add some real ones
  it "should use SearchController" do
    controller.should be_an_instance_of(SearchController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should be successful with parameters" do
      @make = mock_model(Make)
      @model = mock_model(Model)
      @make.stub!(:common_name).and_return("MyString")
      @model.stub!(:common_name).and_return("MyString")
      Make.stub!(:find).and_return(@make)
      Model.stub!(:find).and_return(@model)
      
      get 'index', :make_id => 1, :model_id => 1, :price_range => "100000|200000", :from => 1973, :to => 2000
      response.should be_success
    end
  end
  
  describe "GET 'load_models'" do
    it "should be successful with no params" do
      get 'load_models'
      response.should be_success
      assigns[:models].size.should == 1
    end
    it "should be successful with make_id passed it" do
      get 'load_models', :make_id => 1
      response.should be_success
      assigns[:models].size.should > 0
    end
  end
end
