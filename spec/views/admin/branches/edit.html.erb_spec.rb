require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/branches/edit.html.erb" do
  include Admin::BranchesHelper
  
  before do
    @branch = mock_model(Branch)
    @branch.stub!(:name).and_return("MyString")
    @branch.stub!(:phone).and_return("MyString")
    @branch.stub!(:fax).and_return("MyString")
    @branch.stub!(:address).and_return("MyString")
    @branch.stub!(:stock_code_prefix).and_return("MyString")
    @branch.stub!(:cyberstock_prefix).and_return("MyString")
    assigns[:branch] = @branch
  end

  it "should render edit form" do
    render "/admin/branches/edit.html.erb"
    
    response.should have_tag("form[action=#{admin_branch_path(@branch)}][method=post]") do
      with_tag('input#branch_name[name=?]', "branch[name]")
    end
  end
end


