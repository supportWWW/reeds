require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/branches/show.html.erb" do
  include Admin::BranchesHelper
  
  before(:each) do
    @branch = mock_model(Branch)
    @branch.stub!(:name).and_return("MyString")
    @branch.stub!(:phone).and_return("MyString")
    @branch.stub!(:fax).and_return("MyString")
    @branch.stub!(:address).and_return("MyString")
    @branch.stub!(:stock_code_prefix).and_return("MyString")
    @branch.stub!(:cyberstock_prefix).and_return("MyString")
    @branch.stub!(:assignments).and_return( [] )
    @branch.stub!(:image).and_return(nil)
    
    assigns[:branch] = @branch
  end

  it "should render attributes in <p>" do
    render "/admin/branches/show.html.erb"
    response.should have_text(/MyString/)
  end
end

