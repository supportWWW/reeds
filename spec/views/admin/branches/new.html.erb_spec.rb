require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/branches/new.html.erb" do
  include Admin::BranchesHelper
  
  before(:each) do
    @branch = mock_model(Branch)
    @branch.stub!(:new_record?).and_return(true)
    @branch.stub!(:name).and_return("MyString")
    @branch.stub!(:phone).and_return("MyString")
    @branch.stub!(:fax).and_return("MyString")
    @branch.stub!(:address).and_return("MyString")
    @branch.stub!(:stock_code_prefix).and_return("MyString")
    @branch.stub!(:cyberstock_prefix).and_return("MyString")
    @branch.stub!(:image).and_return(nil)
    assigns[:branch] = @branch
  end

  it "should render new form" do
    render "/admin/branches/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_branches_path) do
      with_tag("input#branch_name[name=?]", "branch[name]")
    end
  end
end


