require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do

  #Delete these examples and add some real ones
  it "should use SearchController" do
    controller.should be_an_instance_of(SearchController)
  end


  describe "GET 'index' for classified" do
    it "should be successful" do
      get 'index', :type => "classified"
      response.should be_success
    end

    it "should be successful with parameters" do
      @make = mock_model(Make)
      @model = mock_model(Model)
      @make.stub!(:common_name).and_return("MyString")
      @model.stub!(:common_name).and_return("MyString")
      Make.stub!(:find).and_return(@make)
      Model.stub!(:find).and_return(@model)
      
      get 'index', :type => "classified", :make_id => 1, :model_id => 1, :price_range => "100000|200000", :from => 1973, :to => 2000
      response.should be_success
    end

    it "should be successful with the price parameter" do
      @make = mock_model(Make)
      @model = mock_model(Model)
      @make.stub!(:common_name).and_return("MyString")
      @model.stub!(:common_name).and_return("MyString")
      Make.stub!(:find).and_return(@make)
      Model.stub!(:find).and_return(@model)
      
      get 'index', :type => "classified", :make_id => 1, :model_id => 1, :price => "165000", :from => 1973, :to => 2000
      response.should be_success
      params[:price_range].should == "160000|180000"
    end
  end

  describe "GET 'index' for new vehicles" do
    it "should be successful" do
      get 'index', :type => "new_vehicle"
      response.should be_success
    end

    it "should be successful with parameters" do
      @make = mock_model(Make)
      @model_range = mock_model(ModelRange)
      @make.stub!(:common_name).and_return("MyString")
      @model_range.stub!(:name).and_return("MyString")
      Make.stub!(:find).and_return(@make)
      ModelRange.stub!(:find).and_return(@model_range)
      
      get 'index', :type => "new_vehicle", :make_id => 1, :model_range_id => 1, :price_range => "100000|200000"
      response.should be_success
    end

    it "should be successful with the price parameter" do
      @make = mock_model(Make)
      @model_range = mock_model(ModelRange)
      @make.stub!(:common_name).and_return("MyString")
      @model_range.stub!(:name).and_return("MyString")
      Make.stub!(:find).and_return(@make)
      ModelRange.stub!(:find).and_return(@model_range)
      
      get 'index', :type => "new_vehicle", :make_id => 1, :model_range_id => 1, :price => "165000"
      response.should be_success
      params[:price_range].should == "160000|180000"
    end
  end
  
  describe "GET 'load_models'" do
    it "should be successful with no params" do
      get 'load_models'
      response.should be_success
      assigns[:models].size.should == 1
    end
    it "should be successful with make_id passed it" do
      @make = mock_model(Make, :find_models_in_stock => [])
      Make.stub!(:find).and_return(@make)
      get 'load_models', :make_id => 1
      response.should be_success
      assigns[:models].size.should > 0
    end
  end

  describe "GET 'load_model_ranges'" do
    it "should be successful with no params" do
      get 'load_model_ranges'
      response.should be_success
      assigns[:model_ranges].size.should == 1
    end
    it "should be successful with make_id passed it" do
      @make = mock_model(Make, :find_model_ranges_in_stock => [])
      Make.stub!(:find).and_return(@make)
      get 'load_model_ranges', :make_id => 1
      response.should be_success
      assigns[:model_ranges].size.should > 0
    end
  end
end
