require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/branches/new.html.erb" do
  include Admin::BranchesHelper
  
  before(:each) do
    @branch = mock_model(Branch)
    @branch.stub!(:new_record?).and_return(true)
    @branch.stub!(:name).and_return("MyString")
    assigns[:branch] = @branch
  end

  it "should render new form" do
    render "/admin/branches/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", admin_branches_path) do
      with_tag("input#branch_name[name=?]", "branch[name]")
    end
  end
end


