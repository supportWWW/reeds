require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/branches/show.html.erb" do
  include BranchesHelper
  
  before(:each) do
    @branch = mock_model(Branch)
    @branch.stub!(:name).and_return("MyString")
    @branch.stub!(:assignments).and_return( [] )
    
    assigns[:branch] = @branch
  end

  it "should render attributes in <p>" do
    render "/branches/show.html.erb"
    response.should have_text(/MyString/)
  end
end

