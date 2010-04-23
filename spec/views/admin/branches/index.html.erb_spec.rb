require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/admin/branches/index.html.erb" do
  include Admin::BranchesHelper
  
  before(:each) do
    branch_98 = mock_model(Branch)
    branch_98.should_receive(:name).and_return("MyString")
    branch_99 = mock_model(Branch)
    branch_99.should_receive(:name).and_return("MyString")

    assigns[:branches] = [branch_98, branch_99]
  end

  it "should render list of branches" do
    render "/admin/branches/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

