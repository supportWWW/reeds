require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::ExporterController do

  before :each do
    @user = mock_model( User, :login => 'test', :name => 'test', :is_admin? => true )
    controller.stub!( :current_user ).and_return( @user )
  end
  

  describe "GET 'export_g2'" do
    it "should be successful" do
      get 'export_g2'
      response.should be_success
    end
  end

  describe "GET 'export_autotrader'" do
    it "should be successful" do
      get 'export_autotrader'
      response.should be_success
    end
  end

  describe "GET 'export_g2' with format=CSV" do
    it "should be successful" do
      get 'export_g2', :format => :csv
      reader = FasterCSV.parse( @response.body, :col_sep => "," )
    end
  end

  describe "GET 'export_autotrader' with format=CSV" do
    it "should be successful" do
      get 'export_autotrader', :format => :csv
      reader = FasterCSV.parse( @response.body, :col_sep => "," )
    end
  end

end
